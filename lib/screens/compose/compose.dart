import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hackathon2021/utilities/colors.dart';

class ComposePage extends StatefulWidget {
  const ComposePage({Key? key}) : super(key: key);

  @override
  _ComposePageState createState() => _ComposePageState();
}

class _ComposePageState extends State<ComposePage> {
  List<String> actions = ["From", "To", "Cc"];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back),
          ),
          title: Text(
            "Compose",
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: width * 0.04),
              child: Icon(Icons.send),
            ),
          ],
        ),
        body: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: width * 0.04),
                    width: width,
                    child: Row(
                      children: [
                        Text(
                          actions[index],
                          style: TextStyle(
                            fontSize: width * 0.05,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: width * 0.05),
                          width: width * 0.77,
                          child: TextField(
                            style: TextStyle(fontSize: width * 0.045),
                            cursorHeight: height * 0.03,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            TextField(
              style: TextStyle(fontSize: width * 0.05),
              cursorHeight: height * 0.03,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(width * 0.04),
                border: InputBorder.none,
                hintText: "Subject",
                hintStyle: TextStyle(
                  fontSize: width * 0.05,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                style: TextStyle(fontSize: width * 0.05),
                cursorHeight: height * 0.03,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(width * 0.04),
                  border: InputBorder.none,
                  hintText: "Body",
                  hintStyle: TextStyle(
                    fontSize: width * 0.05,
                    color: Colors.black,
                  ),
                ),
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
