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

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Auth _auth = new Auth();
  String email = "";
  String password = "";
  bool isLoading = false;

  Widget getBody(Size size, BuildContext context) {
    return isLoading
        ? LoadingWidget()
        : SingleChildScrollView(
            child: Container(
              height: size.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
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
                                      fillColor: Colors.grey,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: kPrimaryColor,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: kPrimaryColor, width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
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
                                              BorderRadius.circular(20),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: kPrimaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        )),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              )
                            ],
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ),
                              );
                            }
                          },
                          textColor: Colors.white,
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: Text(
                              "Login with Google",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: size.width * 0.5,
                          height: size.height * 0.1,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kPrimaryColor,
                          ),
                          child: SvgPicture.asset("assets/images/google.svg"),
                        ),
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
                                      builder: (context) => SignupScreen()))
                            },
                            child: Text(
                              "Don't Have an Account? Sign up",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
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
