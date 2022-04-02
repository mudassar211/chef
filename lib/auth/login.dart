// ignore_for_file: unused_local_variable, prefer_const_constructors, sized_box_for_blackspace, sized_box_for_whitespace

import 'package:chefpractice/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      UserCredential userCredential =
          await auth.signInWithCredential(authCredential);
      User? user = userCredential.user;

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Sign In To Continue',
                    style: TextStyle(color: Colors.black),
                  ),
                  Text('tasteofthirst',
                      style: GoogleFonts.hurricane(
                        color: Colors.black,
                        fontSize: 72,
                      )),
                  Column(
                    children: [
                      SignInButton(
                        Buttons.Apple,
                        text: "Continue with Apple",
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SignInButton(
                        Buttons.Google,
                        text: "Continue with Google",
                        onPressed: () {
                          googleSignIn();
                        },
                      ),
                    ],
                  ),
                  Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        'By signing in you are agreeing to our',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        'Terms and Pricacy Policy',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
