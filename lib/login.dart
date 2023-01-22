import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:chatapp/chat.dart';
import 'package:chatapp/home.dart';
import 'package:chatapp/signup.dart';
import 'package:chatapp/auth_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final form_key = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  Widget button() {
    return ElevatedButton(
      child: Text("Login"),
      onPressed: () {
        submit();
      },
    );
  }

  void submit() async {
    setState(() {
      loading = true;
    });
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text);
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => homepage()));
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      // TODO
    }

    setState(() {
      loading = false;
    });
  }

  signinwithGoogle() async {
    final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleauth =
        await googleuser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleauth.accessToken,
      idToken: googleauth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: loading == true ? Colors.blue[800] : Colors.white,
        appBar: AppBar(
          title: Text("Chat App"),
        ),
        body: loading == true
            ? Center(
                child: SpinKitRotatingCircle(
                  color: Colors.white,
                  size: 50.0,
                ),
              )
            : Form(
                key: form_key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(0.0),
                      child: button(),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => signup())),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text("Signup"),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        signinwithGoogle();
                        print('dada');
                      },
                      child: Text('sign in with google'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
