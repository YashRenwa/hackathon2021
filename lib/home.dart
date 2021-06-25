import 'package:flutter/material.dart';


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
    );
  }


  Widget getBody(size){
    return(
      Column(
        children: [
          Container(
            height:(size.height)*0.3,
            width: (size.width-20),
            decoration: BoxDecoration(

            ),

          ),
        ],
      )
    );
  }
}
