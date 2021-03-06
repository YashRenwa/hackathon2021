import 'package:flutter/material.dart';
import 'package:hackathon2021/utilities/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackathon2021/auth/auth.dart';

class ComposePage extends StatefulWidget {
  const ComposePage({Key? key}) : super(key: key);

  @override
  _ComposePageState createState() => _ComposePageState();
}

class _ComposePageState extends State<ComposePage> {
  String subject = '';
  String body = '';
  String content = '';
  DateTime pickedDate = DateTime.now();
  TimeOfDay pickedTime = TimeOfDay.now();
  String? selectedDay = "Monday";
  String? currentSchedule = "Yearly Schedule";
  List<String> schedules = [
    "Yearly Schedule",
    "Monthly Schedule",
    "Weekly Schedule",
    "Recurring Schedule"
  ];
  Auth _auth = new Auth(FirebaseAuth.instance);
  var currentuser;

  get_current_user() {
    currentuser = FirebaseAuth.instance.currentUser;
    print(currentuser.email);
  }

  @override
  void initState() {
    get_current_user();
    super.initState();
  }

  List<String> actions = ["To", "Cc"];
  List<String> stringactions = ['', ''];
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
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => StatefulBuilder(builder:
                      (BuildContext context,
                          StateSetter setState /*You can rename this!*/) {
                    return SingleChildScrollView(
                      child: Container(
                        height: height * 0.5,
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          color: Color(0xff757575),
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  'Schedule',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                                Center(
                                  child: DropdownButton<String>(
                                    hint: Text(
                                      "Choose Schedule",
                                      style: TextStyle(
                                        fontSize: width * 0.05,
                                      ),
                                    ),
                                    items: schedules.map((String dropDownItem) {
                                      return DropdownMenuItem<String>(
                                        value: dropDownItem,
                                        child: Text(dropDownItem),
                                      );
                                    }).toList(),
                                    value: currentSchedule,
                                    onChanged: (newSchedule) {
                                      setState(() {
                                        currentSchedule = newSchedule;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                                dateAndTime(setState, height, width),
                                SizedBox(height: height * 0.02),
                                Container(
                                  width: (width - 20),
                                  height: (height * 0.07),
                                  child: ElevatedButton(
                                    child: Text(
                                      'SUBMIT',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              kPrimaryColor),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
              child: Container(
                margin: EdgeInsets.only(right: width * 0.04),
                child: Icon(Icons.calendar_today),
              ),
            ),
            GestureDetector(
              onTap: () {
                FirebaseFirestore.instance.collection('data').add(
                  {
                    'address': stringactions[0],
                    'cc': stringactions[1],
                    'choice': currentSchedule,
                    'content': body,
                    'date': pickedDate.day,
                    'day': selectedDay,
                    'month': pickedDate.month,
                    'specific_time': pickedTime.hour,
                    'status': false,
                    'subject': subject,
                    'time': pickedDate,
                    'user': currentuser.email,
                  },
                );
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(right: width * 0.04),
                child: Icon(Icons.send),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
                  width: width,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: width * 0.04),
                        child: Row(
                          children: [
                            Text(
                              actions[index],
                              style: TextStyle(
                                fontSize: width * 0.05,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: width * 0.05),
                              width: width * 0.77,
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    stringactions[index] = value;
                                  });
                                  print(stringactions[index]);
                                },
                                style: TextStyle(fontSize: width * 0.045),
                                cursorHeight: height * 0.03,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width,
                        height: height * 0.001,
                        child: Container(color: Colors.grey),
                      )
                    ],
                  ),
                );
              },
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  subject = value;
                });
                print(subject);
              },
              style: TextStyle(fontSize: width * 0.05),
              cursorHeight: height * 0.03,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(width * 0.04),
                border: InputBorder.none,
                hintText: "Subject",
                hintStyle: TextStyle(
                  fontSize: width * 0.05,
                  color: Colors.grey,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    body = value;
                  });
                  print(subject);
                },
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

  Widget dateAndTime(StateSetter setState, double height, double width) {
    if (currentSchedule == "Recurring Schedule") {
      return Container();
    } else if (currentSchedule == "Weekly Schedule") {
      return Column(
        children: [_pickDay(setState, width)],
      );
    } else {
      return Column(
        children: [
          ListTile(
            title: Text(
                "Date: ${pickedDate.day}-${pickedDate.month}-${pickedDate.year}"),
            trailing: Icon(Icons.keyboard_arrow_down),
            onTap: () {
              _pickdate(setState);
            },
          ),
          SizedBox(height: height * 0.02),
          ListTile(
            title: Text("Time: ${pickedTime.hour}:${pickedTime.minute}"),
            trailing: Icon(Icons.keyboard_arrow_down),
            onTap: () {
              _picktime(setState);
            },
          ),
        ],
      );
    }
  }

  _pickdate(StateSetter setState) async {
    var date = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));

    if (date != null)
      setState(() {
        pickedDate = date;
      });
  }

  _picktime(StateSetter setState) async {
    var time = await showTimePicker(
      context: context,
      initialTime: pickedTime,
    );

    if (time != null)
      setState(() {
        pickedTime = time;
      });
  }

  _pickDay(StateSetter stateSetter, double width) {
    return DropdownButton<String>(
      hint: Text(
        "Choose Schedule",
        style: TextStyle(
          fontSize: width * 0.05,
        ),
      ),
      items: [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday"
      ].map((String dropDownItem) {
        return DropdownMenuItem<String>(
          value: dropDownItem,
          child: Text(dropDownItem),
        );
      }).toList(),
      value: selectedDay,
      onChanged: (day) {
        stateSetter(() {
          selectedDay = day;
        });
      },
    );
  }
}
