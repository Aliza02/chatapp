import 'package:chatapp/auth_method.dart';
import 'package:chatapp/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Signup"),
        ),
        body: Column(
          children: [
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your Name',
              ),
            ),
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
            ),
            TextFormField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'password',
                hintText: 'Enter your password',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (name.text.isNotEmpty &&
                    email.text.isNotEmpty &&
                    password.text.isNotEmpty) {
                  Signup(
                          name: name.text,
                          email: email.text,
                          password: password.text)
                      .then((user) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => homepage()));
                    if (user != null) {
                      print('asdad');
                    }
                  });
                }
              },
              child: Text("Signup"),
            ),
          ],
        ),
      ),
    );
  }
}
