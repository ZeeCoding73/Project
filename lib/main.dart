import 'package:firebase_core/firebase_core.dart';
import 'package:fitness/controllers/auth_controller.dart';
import 'package:fitness/firebase_options.dart';
import 'package:fitness/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/colo_extension.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put<AuthController>(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fitness 3 in 1',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(primaryColor: TColor.primaryColor1, fontFamily: "Poppins"),
      home: SplashUI(),

      ///home: const MainTabView(),
    );
  }
}
