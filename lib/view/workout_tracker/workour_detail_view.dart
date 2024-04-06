// ignore_for_file: prefer_const_constructors

import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/common/constants.dart';
import 'package:fitness/common/my_list_tile.dart';
import 'package:fitness/common_widget/icon_title_next_row.dart';
import 'package:fitness/common_widget/round_button.dart';
import 'package:fitness/view/workout_tracker/Excercises_list.dart';
import 'package:fitness/view/workout_tracker/exercises_stpe_details.dart';
import 'package:fitness/view/workout_tracker/workout_schedule_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common_widget/exercises_set_section.dart';
import 'excercise_details_pages/chest_details.dart';

class WorkoutDetailView extends StatefulWidget {
  final Map dObj;
  const WorkoutDetailView({super.key, required this.dObj});

  @override
  State<WorkoutDetailView> createState() => _WorkoutDetailViewState();
}

class _WorkoutDetailViewState extends State<WorkoutDetailView> {
  List latestArr = [
    {
      "image": "assets/img/Workout1.png",
      "title": "Fullbody Workout",
      "time": "Today, 03:00pm"
    },
    {
      "image": "assets/img/Workout2.png",
      "title": "Upperbody Workout",
      "time": "June 05, 02:00pm"
    },
  ];

  List youArr = [
    {"image": "assets/img/barbell.png", "title": "Barbell"},
    {"image": "assets/img/skipping_rope.png", "title": "Skipping Rope"},
    {"image": "assets/img/gymequip1.png", "title": "Chest Press Machine"},
    {"image": "assets/img/gymequip2.png", "title": "Cable Tower Machine"},
    {"image": "assets/img/bottle.png", "title": "Water Bottle"},
  ];

  List<String> exercisesArr = [
    'Chest',
    'Shoulders',
    'Bicep',
    'Back',
    'Forearm',
    'Neck',
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      decoration:
          BoxDecoration(gradient: LinearGradient(colors: TColor.primaryG)),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: TColor.lightGray,
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(
                    "assets/img/black_btn.png",
                    width: 15,
                    height: 15,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              actions: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: TColor.lightGray,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(
                      "assets/img/more_btn.png",
                      width: 15,
                      height: 15,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              ],
            ),
            SliverAppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              leadingWidth: 0,
              leading: Container(),
              expandedHeight: media.width * 0.5,
              flexibleSpace: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/img/detail_top.png",
                  width: media.width * 0.75,
                  height: media.width * 0.8,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ];
        },
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: TColor.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 50,
                        height: 4,
                        decoration: BoxDecoration(
                            color: TColor.gray.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(3)),
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.dObj["title"].toString(),
                                  style: TextStyle(
                                      color: TColor.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "${widget.dObj["exercises"].toString()} | ${widget.dObj["time"].toString()} | 320 Calories Burn",
                                  style: TextStyle(
                                      color: TColor.gray, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Image.asset(
                              "assets/img/fav.png",
                              width: 15,
                              height: 15,
                              fit: BoxFit.contain,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      IconTitleNextRow(
                          icon: "assets/img/time.png",
                          title: "Schedule Workout",
                          time: "5/27, 09:00 AM",
                          color: TColor.primaryColor2.withOpacity(0.3),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const WorkoutScheduleView()));
                          }),
                      SizedBox(
                        height: media.width * 0.02,
                      ),
                      IconTitleNextRow(
                          icon: "assets/img/difficulity.png",
                          title: "Difficulity",
                          time: "Beginner",
                          color: TColor.secondaryColor2.withOpacity(0.3),
                          onPressed: () {}),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "You'll Need",
                            style: TextStyle(
                                color: TColor.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "${youArr.length} Items",
                              style:
                                  TextStyle(color: TColor.gray, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.5,
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: youArr.length,
                            itemBuilder: (context, index) {
                              var yObj = youArr[index] as Map? ?? {};
                              return Container(
                                  margin: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: media.width * 0.35,
                                        width: media.width * 0.35,
                                        decoration: BoxDecoration(
                                            color: TColor.lightGray,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          yObj["image"].toString(),
                                          width: media.width * 0.2,
                                          height: media.width * 0.2,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          yObj["title"].toString(),
                                          style: TextStyle(
                                              color: TColor.black,
                                              fontSize: 12),
                                        ),
                                      )
                                    ],
                                  ));
                            }),
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Exercises",
                            style: TextStyle(
                                color: TColor.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "${youArr.length} Sets",
                              style:
                                  TextStyle(color: TColor.gray, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Excercises_List(index: index,),
                                    ),
                                  );
                                },
                                child: MyListTile(
                                  iconImagePath: MyConstants.myListImages[index]
                                      ['img'],
                                  tileTitle: MyConstants.myListImages[index]
                                      ['title'],
                                  tileSubTitle: MyConstants.myListImages[index]
                                      ['excersize'],
                                ),
                              );
                            },
                            itemCount: MyConstants.myListImages.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(color: Colors.black);
                            },
                          ),
                        ),

                        // Column(
                        //   // ignore: prefer_const_literals_to_create_immutables
                        //   children: [
                        //     GestureDetector(
                        // onTap:(){
                        //   Get.to(()=>ExercisesStepDetails(eObj:{
                        //     'title':'sikander'
                        //   }));
                        // },
                        //       child: MyListTile(
                        //           iconImagePath: 'assets/img/chest.png',
                        //           tileTitle: 'Chest',
                        //           tileSubTitle: '6 Excercises'),
                        //     ),
                        //     Divider(
                        //       color: Colors.black,
                        //     ),
                        //
                        //     MyListTile(
                        //         iconImagePath: 'assets/img/forearm.png',
                        //         tileTitle: 'ForeArms',
                        //         tileSubTitle: '5 Excercises'),
                        //     Divider(
                        //       color: Colors.black,
                        //     ),
                        //
                        //
                        //
                        //     MyListTile(
                        //           iconImagePath: 'assets/img/back.png',
                        //           tileTitle: 'Back',
                        //           tileSubTitle: '3 Excercises'),
                        //
                        //     Divider(
                        //       color: Colors.black,
                        //     ),
                        //     MyListTile(
                        //         iconImagePath: 'assets/img/abs.png',
                        //         tileTitle: 'Abs',
                        //         tileSubTitle: '5 Excercises'),
                        //     Divider(
                        //       color: Colors.black,
                        //     ),
                        //     MyListTile(
                        //         iconImagePath: 'assets/img/shoulder.png',
                        //         tileTitle: 'Shoulders',
                        //         tileSubTitle: '4 Excercises'),
                        //     Divider(
                        //       color: Colors.black,
                        //     ),
                        //     MyListTile(
                        //         iconImagePath: 'assets/img/traps.png',
                        //         tileTitle: 'Traps',
                        //         tileSubTitle: '6 Excercises'),
                        //     Divider(
                        //       color: Colors.black,
                        //     ),
                        //     MyListTile(
                        //         iconImagePath: 'assets/img/legs.png',
                        //         tileTitle: 'Legs',
                        //         tileSubTitle: '6 Excercises'),
                        //
                        //     Divider(
                        //       color: Colors.black,
                        //     ),
                        //     MyListTile(
                        //         iconImagePath: 'assets/img/calf.png',
                        //         tileTitle: 'Calfs',
                        //         tileSubTitle: '6 Excercises'),
                        //   ],
                        // ),
                      ),
                      SizedBox(
                        height: media.width * 0.1,
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
