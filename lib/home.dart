import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon2021/auth/auth.dart';
import 'package:hackathon2021/screens/compose/compose.dart';
import 'package:hackathon2021/screens/welcome/body.dart';
import 'package:hackathon2021/utilities/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Auth _auth = new Auth(FirebaseAuth.instance);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: Container(),
          title: Text(
            "Mail Manager",
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                await _auth.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()));
              },
              child: Container(
                margin: EdgeInsets.only(right: size.width * 0.03),
                child: Icon(Icons.logout_outlined),
              ),
            )
          ],
        ),
        body: getBody(size),
        floatingActionButton: GestureDetector(
          child: FloatingActionButton.extended(
            icon: Icon(Icons.edit),
            label: Text("New Draft"),
            backgroundColor: kPrimaryColor,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ComposePage(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getBody(size) {
    return (Column(
      children: [
        Container(
          height: (size.height) * 0.3,
          width: (size.width - 20),
          decoration: BoxDecoration(),
        ),
      ],
    ));
  }
}
