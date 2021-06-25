import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';

class ResColor extends HexColor {
  final String hexColor;
  ResColor(this.hexColor) : super(hexColor);

  // solid
  static ResColor lightRed = ResColor('FB7E77');
  static ResColor lightGreen = ResColor('74BE5A');
  static ResColor lightGrey = ResColor('F3F3F3');
  static Color lightGrey300 = Colors.grey[300];
  static ResColor lightYellow = ResColor('EBDA82');
  static ResColor darkYellow = ResColor('E4C419');
  static ResColor lightOrange = ResColor('FFB400');
  static ResColor darkOrange = ResColor('EB7E44');
  static ResColor lightBlue = ResColor('667DA9');
  static ResColor darkBlue = ResColor('04294F');

  static Color appBackground = HexColor('F3F3F3');
  static Color primaryColor = HexColor('F34949');
  static Color primaryDarkColor = HexColor('BD5454');
  static Color accentColor = HexColor('FF8C9F');
  static Color profileBgColor = HexColor('B4B4B4');

  // gradient
  static Gradient cardGradient = LinearGradient(colors: <Color>[
    HexColor('04294F'),
    HexColor('215C98'),
  ]);

  // gradient
  static Gradient budgetGradient = LinearGradient(colors: <Color>[
    HexColor('5581F1'),
    HexColor('1153FC'),
  ], end: Alignment.topLeft, begin: Alignment.bottomRight);

  static Gradient budgetBarGradient = LinearGradient(
    colors: <Color>[
      HexColor('A1051D'),
      HexColor('F5515F'),
    ],
  );

  // gradient
  static Gradient redGradient = LinearGradient(colors: <Color>[
    HexColor('FACD68'),
    HexColor('FC76B3'),
  ], end: Alignment.topLeft, begin: Alignment.bottomRight);

  static Gradient yellowGradient = LinearGradient(colors: <Color>[
    HexColor('FFE324'),
    HexColor('FEAD20'),
  ], end: Alignment.topLeft, begin: Alignment.bottomRight);

  static Gradient greenGradient = LinearGradient(colors: <Color>[
    HexColor('00F7A7'),
    HexColor('00D3CC'),
  ], end: Alignment.topLeft, begin: Alignment.bottomRight);
}
