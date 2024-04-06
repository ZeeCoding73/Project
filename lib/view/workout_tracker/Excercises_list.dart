import 'package:fitness/common/constants.dart';
import 'package:flutter/material.dart';

class Excercises_List extends StatefulWidget {
  int index;
   Excercises_List({super.key,required this.index});

  @override
  State<Excercises_List> createState() => _Excercises_ListState();
}

class _Excercises_ListState extends State<Excercises_List> {


  //list will be herer

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyConstants.myListImages[widget.index]['title']),
      ),
    );
  }
}
