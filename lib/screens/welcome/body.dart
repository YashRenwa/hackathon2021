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
    return Scaffold(
      body:getBody(size,context),
    );
  }
  
  
  Widget getBody(size,context){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "WELCOME",
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height:size.height*0.1),
          SvgPicture.asset("assets/images/welcome.svg", height:size.height*0.4),
          SizedBox(height:size.height*0.1),
          RoundButton(
            text:"LOGIN",
            color: kPrimaryColor,
            textColor: kTextColor,
            press:(){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }

          ),
          RoundButton(
              text:"SIGN-UP",
              color: kPrimaryColor,
              textColor: kTextColor,
              press:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              }

          ),
        ],
      ),
    );
    
  }
}

