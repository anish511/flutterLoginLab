// @dart=2.9
import 'package:flutter/material.dart';
import 'package:my_first_android_flutter_project/home.dart';
import 'package:my_first_android_flutter_project/register.dart';

import 'login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login': (context) => MyLogin(),
      'register':(context) => MyRegister(),
      'home':(context) => HomePage()
    },
  ));
}

