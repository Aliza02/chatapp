import 'package:flutter/animation.dart';

class onboarding_model {
  onboarding_model(
      {required this.heading,
      required this.description,
      required this.image,
      required this.color1,
      required this.color2});
  String heading;
  String description;
  String image;
  int color1;
  int color2;
}

List<onboarding_model> content = [
  onboarding_model(
      heading: 'Growth in sales with broader customer reach',
      description: 'adsa',
      image: 'assets/images/page2.png',
      color1: 0xFFF57366,
      color2: 0xFFFFAF4A),

  onboarding_model(
      heading: 'dadad',
      description: 'abc',
      image: 'assets/images/page2.png',
      color1: 0xFFF45C1C1,
      color2: 0xFFFF57366),
  // onboarding_model(heading: 'Second page', description: 'ndjnsjknasn'),
  // onboarding_model(heading: 'Third page', description: 'qwoieoqiepq'),
];
