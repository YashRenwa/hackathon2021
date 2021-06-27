import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import "package:hackathon2021/components/round_button.dart";
import 'package:hackathon2021/screens/login/login_screen.dart';
import 'package:hackathon2021/utilities/colors.dart';
import "package:hackathon2021/screens/sign-up/Signup.dart";

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: getBody(size, context),
      ),
    );
  }

  Widget getBody(size, context) {
    return Container(
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Mail Manager",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: size.width * 0.07),
          ),
          SizedBox(height: size.height * 0.1),
          SvgPicture.asset("assets/images/welcome.svg",
              height: size.height * 0.4),
          SizedBox(height: size.height * 0.1),
          RoundButton(
              text: "LOGIN",
              color: kPrimaryColor,
              textColor: kTextColor,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              }),
          RoundButton(
              text: "SIGN-UP",
              color: kPrimaryColor,
              textColor: kTextColor,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Signup()),
                );
              }),
        ],
      ),
    );
  }
}
