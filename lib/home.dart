import 'package:flutter/material.dart';
import 'package:hackathon2021/screens/compose/compose.dart';
import 'package:hackathon2021/utilities/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
