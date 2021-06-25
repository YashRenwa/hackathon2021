import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import "package:hackathon2021/utilities/colors.dart";

class RoundButton extends StatelessWidget {
  RoundButton({required this.text, required this.press,required this.color,required this.textColor});
  final String text;
  final Function press;
  final Color color, textColor;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width*0.8,
      height: size.height*0.08,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextButton(

           child: Center(
             child: Text(
               text,
               style:kTextone,
             ),
           ),
        onPressed: ()=>press(),
      ),
      // child: Center(
      //   child: Text(
      //     text,
      //     style: kTextone,
      //
      //   ),
      // ),
    );
  }
}
