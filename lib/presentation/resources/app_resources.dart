import 'package:flutter/material.dart';
import 'dart:math';

class AppColors {
  static const Color contentColorBlue = Colors.blue;
  static const Color contentColorYellow = Colors.yellow;
  static const Color contentColorPurple = Colors.purple;
  static const Color contentColorGreen = Colors.green;
  static const Color contentColorRed = Colors.red;
  static const Color contentColorOrange = Colors.orange;
  static const Color contentColorPink = Colors.pink;
  static const Color contentColorBrown = Colors.brown;
  static const Color contentColorCyan = Colors.cyan;
  static const Color contentColorIndigo = Colors.indigo;
  static const Color contentColorLime = Colors.lime;
  static const Color contentColorTeal = Colors.teal;

  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.black;
  static const Color mainTextColor3 = Colors.grey;

  static const Color pageBackground = Colors.grey;
  static const Color appBarBackground = Colors.blueGrey;
  static const Color buttonBackground = Colors.lightBlue;

  static const List<Color> allColours = [
    AppColors.contentColorGreen,
    AppColors.contentColorYellow,
    AppColors.contentColorPurple,
    AppColors.contentColorGreen,
    AppColors.contentColorRed,
    AppColors.contentColorOrange,
    AppColors.contentColorPink,
    AppColors.contentColorBrown,
    AppColors.contentColorCyan,
    AppColors.contentColorIndigo,
    AppColors.contentColorLime,
    AppColors.contentColorTeal,
    AppColors.mainTextColor2,
    AppColors.pageBackground,
    AppColors.appBarBackground,
    AppColors.buttonBackground,
  ];
  static Color randomColor(){
    final random = Random();
    return allColours[random.nextInt(allColours.length)];
  }
}


class AppTexts {
  static const String appName = 'Cash Drawer';
}
