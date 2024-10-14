// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';
import '../view/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker App',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          onSurface: Colors.black,
          surface: Colors.grey.shade100,
          primary: const Color(0xff00B2E7),
          secondary: const Color(0xffE064F7),
          tertiary: const Color(0xffFF8D6c)
        ),
        useMaterial3: true,
      ),
      home:HomeScreen() ,
    );
  }
}

