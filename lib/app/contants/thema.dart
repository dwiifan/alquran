import 'package:flutter/material.dart';

Color kPrimaryColor = Color(0xff5C40CC);
Color kBlackColor = Color(0xff1F1449);
Color kWhiteColor = Color(0xffFFFFFF);
Color kGreyColor = Color(0xff9698A9);
Color kPurpleColor = Color(0xff431AA1);
Color kPurpleDrakColor = Color(0xff1E0771);
Color kPurpleLight1Color = Color(0xff9345F2);
Color kPurpleLight2Color = Color(0xffB9A2D8);
Color kOrangeColor = Color(0xffE6704A);

ThemeData themaLight = ThemeData(
  brightness: Brightness.light,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: kPurpleColor),
  primaryColor: kPurpleColor,
  scaffoldBackgroundColor: kWhiteColor,
  appBarTheme: AppBarTheme(
    elevation: 4,
    backgroundColor: kPurpleDrakColor,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: kPurpleDrakColor,
    ),
    bodyText2: TextStyle(
      color: kPurpleDrakColor,
    ),
  ),
  listTileTheme: ListTileThemeData(
    textColor: kPurpleColor,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: kPurpleColor,
    unselectedLabelColor: kGreyColor,
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: kPurpleColor,
        ),
      ),
    ),
  ),
);

ThemeData themaDark = ThemeData(
  brightness: Brightness.dark,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: kWhiteColor),
  primaryColor: kPurpleLight2Color,
  scaffoldBackgroundColor: kPurpleDrakColor,
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: kPurpleDrakColor,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: kWhiteColor,
    ),
    bodyText2: TextStyle(
      color: kWhiteColor,
    ),
  ),
  listTileTheme: ListTileThemeData(
    textColor: kWhiteColor,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: kWhiteColor,
    unselectedLabelColor: kGreyColor,
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: kWhiteColor,
        ),
      ),
    ),
  ),
);
