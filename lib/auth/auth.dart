import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  FirebaseAuth _auth;

  Auth(this._auth);

  Stream<User?> get authStateChanges => _auth.authStateChanges();

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

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
          print(e.code);
        } else if (e.code == 'invalid-credential') {
          // handle the error here
          print(e.code);
        }
      } catch (e) {
        // handle the error here
        print(e);
      }
    } else {
      print("Error");
    }

    return user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  bool isLoggedIn() {
    bool result = false;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        result = false;
      } else {
        result = true;
      }
    });
    return result;
  }
}
