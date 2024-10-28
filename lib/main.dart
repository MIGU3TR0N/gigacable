import 'package:flutter/material.dart';
import 'package:gigacable/provider/profile_provider.dart';
import 'package:gigacable/screens/home_screen.dart';
import 'package:gigacable/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
      child: MaterialApp(
        title: 'GigaCable',
        debugShowCheckedModeBanner: false,
        home: const LoginScreen(),
        routes: {
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}