import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hackathon2021/auth/auth.dart';
import 'package:hackathon2021/components/loading.dart';
import "package:hackathon2021/components/round_button.dart";
import 'package:hackathon2021/home.dart';
import 'package:hackathon2021/screens/sign-up/Signup.dart';
import 'package:hackathon2021/utilities/colors.dart';
import 'package:hackathon2021/components/input_field.dart';
import 'package:provider/src/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Auth _auth = new Auth(FirebaseAuth.instance);
  String email = "";
  String password = "";
  bool isLoading = false;
  String errorMessage = "";

  Widget getBody(Size size, BuildContext context) {
    return isLoading
        ? LoadingWidget()
        : SingleChildScrollView(
            child: Container(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.1),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TextField(
                                    obscureText: false,
                                    onChanged: (value) {
                                      setState(() {
                                        email = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: kPrimaryColor,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: kPrimaryColor, width: 2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusColor: kPrimaryColor,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                              SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Password",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TextField(
                                    obscureText: true,
                                    onChanged: (value) {
                                      setState(() {
                                        password = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 10),
                                        fillColor: Colors.grey,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: kPrimaryColor,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: kPrimaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          errorMessage,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: size.width * 0.04,
                          ),
                        ),
                        SizedBox(height: 20),
                        RoundButton(
                          color: kPrimaryColor,
                          text: "LOGIN",
                          press: () async {
                            setState(() {
                              isLoading = true;
                            });
                            var result = await _auth.logIn(email, password);
                            if (result == "success") {
                              setState(() {
                                errorMessage = result;
                                isLoading = false;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ),
                              );
                            } else {
                              setState(() {
                                errorMessage = result;
                                isLoading = false;
                              });
                            }
                          },
                          textColor: Colors.white,
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () async {
                            var user =
                                await _auth.signInWithGoogle(context: context);
                            print(user);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: size.height * 0.03,
                                child: Image(
                                  image: AssetImage("assets/images/search.png"),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 20),
                                child: Text(
                                  "Login with Google",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: GestureDetector(
                              onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignupScreen()))
                                  },
                              child: Text(
                                "Don't Have an Account? Sign up",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  // Widget InputFile({label, obscureText = false}) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Text(
  //         label,
  //         style: TextStyle(
  //             fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
  //       ),
  //       SizedBox(
  //         height: 5,
  //       ),
  //       TextField(
  //         obscureText: obscureText,
  //         decoration: InputDecoration(
  //             contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
  //             fillColor: Colors.grey,
  //             enabledBorder: OutlineInputBorder(
  //               borderSide: BorderSide(
  //                 color: kPrimaryColor,
  //                 width: 2,
  //               ),
  //               borderRadius: BorderRadius.circular(20),
  //             ),
  //             border: OutlineInputBorder(
  //               borderSide: BorderSide(color: kPrimaryColor, width: 2),
  //               borderRadius: BorderRadius.circular(20),
  //             )),
  //       ),
  //       SizedBox(height: 10),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "login",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        body: getBody(size, context),
      ),
    );
  }
}
