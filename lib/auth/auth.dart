import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> logIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print(userCredential.user!.email.toString());
      return "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user';
      }
    }
    return "Enter all fields";
  }
}
