import 'package:flutter/material.dart';
class MyListTile extends StatelessWidget {
  final String iconImagePath;
  final String tileTitle;
  final String tileSubTitle;
  const MyListTile({Key? key,
required this.iconImagePath,
required this.tileTitle,
required this.tileSubTitle,
  }) : super (key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //icon
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              height: 80,
              child:
              Image.asset(iconImagePath),
            ),
            const SizedBox(
              width: 20,
            ),
             Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
    tileTitle,

                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
    tileSubTitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        Icon(Icons.arrow_forward_ios),]
    );
  }
}
