import 'package:flutter/material.dart';
import 'package:rannlabapplication/pages/splashScreen.dart';
import '/pages/index.dart';
import '/themes/color.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: primary),
      home: SplashScreen(),
    ));
