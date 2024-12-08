import 'package:flutter/material.dart';
import 'package:gigacable/provider/profile_provider.dart';
import 'package:gigacable/screens/calendarscreen.dart';
import 'package:gigacable/screens/display2_screen.dart';
import 'package:gigacable/screens/display_screen.dart';
import 'package:gigacable/screens/home_screen.dart';
import 'package:gigacable/screens/login_screen.dart';
import 'package:gigacable/screens/service_screen.dart';
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
        initialRoute: '/login',
        title: 'GigaCable',
        debugShowCheckedModeBanner: false,
        home: const LoginScreen(),
        routes: {
          '/home': (context) => const HomeScreen(),
          '/services': (context) => const ServiceScreen(),
          '/servicedetails': (context) => DisplayScreen(),
          '/servicedetails2': (context) =>  Display2Screen(),
          '/calendario':(context) => const Calendarscreen(),
        },
      ),
    );
  }
}