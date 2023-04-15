import 'package:flutter/material.dart';
import 'package:noua_virtual/home_page.dart';
import 'package:noua_virtual/pallete.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Noua',
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Pallete.blackColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Pallete.blackColor,
        ),
      ),
      home: const HomePage(),
    );
  }
}
