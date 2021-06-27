import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon2021/auth/auth.dart';
import 'package:hackathon2021/screens/compose/compose.dart';
import 'package:hackathon2021/screens/welcome/body.dart';
import 'package:hackathon2021/utilities/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Auth _auth = new Auth(FirebaseAuth.instance);
  final _firestore = FirebaseFirestore.instance;
  var currentuser;

  get_current_user() {
    currentuser = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    get_current_user();
    super.initState();
  }

  Widget mailcard(String subjectdata, bool sent_status, String user, document) {
    if (user == currentuser.email) {
      return Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        height: 100,
        width: double.maxFinite,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    subjectdata,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    sent_status
                        ? Icon(Icons.check_box)
                        : Icon(Icons.lock_clock),
                    sent_status ? Text('sent') : Text('waiting'),
                    GestureDetector(
                      onTap: () async {
                        await FirebaseFirestore.instance
                            .runTransaction((Transaction myTransaction) async {
                          await myTransaction.delete(document.reference);
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Icon(Icons.delete),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          elevation: 5,
        ),
      );
    } else
      return Container();
  }

  final Stream<QuerySnapshot> _emailStream =
      FirebaseFirestore.instance.collection('data').snapshots();

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
                child: Icon(Icons.logout),
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
    return StreamBuilder<QuerySnapshot>(
      stream: _emailStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;

            return mailcard(
                data['subject'], data['status'], data['user'], document);
          }).toList(),
        );
      },
    );
  }
}
