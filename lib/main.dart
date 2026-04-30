import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kids_game/screens/color_identification_screen.dart';
import 'package:kids_game/screens/letter_tracing_screen.dart';
import 'package:kids_game/screens/number_tracing_screen.dart';
import 'package:kids_game/screens/welcome_screen.dart';

void main() {
  runApp(ProviderScope(child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/letter_tracing_screen': (context) => LetterTracingScreen(),
        '/number_tracing_screen': (context) => NumberTracingScreen(),
        '/color_identification_screen': (context) => ColorIdentificationScreen()
      },
    );
  }
}

