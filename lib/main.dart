import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:restoran_desti/ui/resto_detail_screen.dart';
import 'package:restoran_desti/ui/resto_list_screen.dart';
import 'package:restoran_desti/ui/resto_search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restoran Cepat Sajin',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: AnimatedSplashScreen(
        splash: Image.asset(
          'splashScreenIcon.png',
        ),
        backgroundColor: Colors.white,
        duration: 1500,
        splashTransition: SplashTransition.scaleTransition,
        nextScreen: const RestoListScreen(),
      ),
      routes: {
        RestoDetailScreen.routeName: (context) => RestoDetailScreen(
              id: ModalRoute.of(context)?.settings.arguments as String,
            ),
        RestoSearchScreen.routeName: (context) => const RestoSearchScreen()
      },
    );
  }
}
