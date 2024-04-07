import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/common_widget/gavatar.dart';
import 'package:fitness/models/user_model.dart';
import 'package:fitness/view/auth_screens/signup_view.dart';
import 'package:fitness/view/home/home_view.dart';
import 'package:fitness/view/main_tab/main_tab_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Rxn<User> firebaseUser = Rxn<User>();
  Stream<User?> get user => _auth.authStateChanges();
  Rxn<UserModel> firestoreUser = Rxn<UserModel>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void onReady() async {
    ever(firebaseUser, handleAuthChanged);

    firebaseUser.bindStream(user);

    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  handleAuthChanged(_firebaseUser) async {
    if (_firebaseUser?.uid != null) {
      firestoreUser.bindStream(streamFirestoreUser());
    }
    if (_firebaseUser == null) {
      print('Send to signin');
      Get.offAll(() => SignUpView());
    } else {
      Get.offAll(() => MainTabView());
    }
  }

  Stream<UserModel> streamFirestoreUser() {
    print('streamFirestoreUser()');

    return _db
        .doc('/users/${firebaseUser.value!.uid}')
        .snapshots()
        .map((snapshot) => UserModel.fromMap(snapshot.data()!));
  }

  registerWithEmailAndPassword(BuildContext context) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((result) async {
        print('uID: ' + result.user!.uid.toString());
        print('email: ' + result.user!.email.toString());
        //get photo url from gravatar if user has one
        Gravatar gravatar = Gravatar(emailController.text);
        String gravatarUrl = gravatar.imageUrl(
          size: 200,
          defaultImage: GravatarImage.retro,
          rating: GravatarRating.pg,
          fileExtension: true,
        );
        UserModel _newUser = UserModel(
          uid: result.user!.uid,
          email: result.user!.email!,
          name: nameController.text,
          dummyPhotoUrl: gravatarUrl,
          photoUrl: null,
        );
        _createUserFirestore(_newUser, result.user!);
        emailController.clear();
        passwordController.clear();
      });
    } on FirebaseAuthException catch (error) {
      Get.snackbar('auth.signUpErrorTitle'.tr, error.message!,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  void _createUserFirestore(UserModel user, User _firebaseUser) {
    _db.doc('/users/${_firebaseUser.uid}').set(user.toJson());
    update();
  }

  Future<void> googleSignInFunction(BuildContext context) async {
    if (kIsWeb) {
      try {
        GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
        googleAuthProvider
            .addScope('https://www.googleapis.com/auth/userinfo.email');

        await _auth.signInWithPopup(googleAuthProvider);
      } on FirebaseAuthException catch (e) {
        print(e);
      }
    } else {
      try {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;
        // if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        //create a new Credentionl
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        print('userCredentials : $userCredential');
        print(
            'given name : ....... ${userCredential.additionalUserInfo!.profile!['given_name']}');
        print(
            'name : ....... ${userCredential.additionalUserInfo!.profile!['name']}');
        Gravatar gravatar = Gravatar(userCredential.user!.email!);
        String gravatarUrl = gravatar.imageUrl(
          size: 200,
          defaultImage: GravatarImage.retro,
          rating: GravatarRating.pg,
          fileExtension: true,
        );
        UserModel _newUser = UserModel(
          uid: userCredential.user!.uid,
          email: userCredential.user!.email!,
          name: userCredential.user!.displayName!,
          dummyPhotoUrl: gravatarUrl,
          photoUrl: userCredential.user!.photoURL!,
        );
        _createUserFirestore(_newUser, userCredential.user!);

        if (userCredential.user != null) {
          if (userCredential.additionalUserInfo!.isNewUser) {
            print(
                'google new user : ${userCredential.additionalUserInfo!.isNewUser}');
          }
        } else {
          print('google user credentials : null');
        }
        // } else {
        //   print('google access/id token null');
        // }
        //1st ends
      } on FirebaseAuthException catch (e) {
        print(e);
      }
    }
  }

  signInWithEmailAndPassword(BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      emailController.clear();
      passwordController.clear();
    } catch (error) {
      Get.snackbar('auth.signInErrorTitle'.tr, 'auth.signInError'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  Future<void> signOut() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    return _auth.signOut();
  }
}
