// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

TextStyle appHeading(double size,Color color,{FontWeight weight=FontWeight.w400}) {
  return TextStyle(
    fontFamily: 'Kodchasan',
    fontSize: size,
    color: color,
    fontWeight: weight,
    
  );
}
TextStyle appHeadingBold(double size,Color color,{FontWeight weight=FontWeight.w400}) {
  return TextStyle(
    fontFamily: 'Kodchasan-bold',
    fontSize: size,
    color: color,
    fontWeight: weight
  );
}
