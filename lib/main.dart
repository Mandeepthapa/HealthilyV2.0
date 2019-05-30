import 'package:flutter/material.dart';
import './ui/Login.dart';

void main(){
  runApp(MaterialApp(
    title: "Healthily V2.0",
    theme: ThemeData(
      primarySwatch: Colors.blue
    ),
    home: new LoginPage(),
    debugShowCheckedModeBanner: false,
  ));
}

