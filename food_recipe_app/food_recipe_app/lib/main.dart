import 'package:flutter/material.dart';
import 'package:food_recipe_app/pages/home_screen/detail_screen.dart';
import 'package:food_recipe_app/pages/home_screen/home_page.dart';
import 'package:food_recipe_app/routes/routes.dart';

import 'bottom_bar/bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // initialRoute: '/',
      routes: {
        Routes.bottomNaviBar:(context) => BottomNaviBar(),
        Routes.homePage:(context) => HomePage(),
        Routes.detailScreen:(context) => DetailScreen(id: '',),
      },
      home: DetailScreen(id: '',),
    );
  }
}
