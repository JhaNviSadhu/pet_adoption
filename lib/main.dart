import 'package:flutter/material.dart';
import 'package:pet_adoption/screens/home.dart';
import 'package:pet_adoption/utils/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pet Adoption',
      theme: ThemeData(
        primarySwatch: mycolor,
      ),
      home: const HomeScreen(),
    );
  }
}
