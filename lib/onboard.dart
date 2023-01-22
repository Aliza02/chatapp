import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:chatapp/onboardpage_model.dart';

class onboard extends StatefulWidget {
  const onboard({super.key});

  @override
  State<onboard> createState() => _onboardState();
}

class _onboardState extends State<onboard> {
  // onboarding_model pages=onboarding_model(heading: heading, description: description)
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageView.builder(
          itemCount: content.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [
                    0.4,
                    1,
                  ],
                      colors: [
                    Color(content[index].color1),
                    Color(content[index].color2),
                  ])),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              // color: Colors.greenAccent,
              // margin: EdgeInsets.all(200.0),
              child: Column(
                children: [
                  Container(
                    // color: Colors.teal,
                    // height: MediaQuery.of(context).size.height * 0.9,
                    // width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.fromLTRB(0.0,
                        MediaQuery.of(context).size.height * 0.2, 0.0, 0.0),
                    child: Image.asset(
                      content[index].image,
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      content[index].heading,
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Averia Sans Libre',
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
