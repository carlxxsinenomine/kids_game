import 'package:flutter/material.dart';
import 'package:kids_game/screens/letter_tracing_screen.dart';
import 'package:kids_game/screens/number_tracing_screen.dart';
import 'package:kids_game/screens/color_identification_screen.dart';

import '../components/welcome_screen/GameCard.dart';
import '../models/GameMode.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final List<GameMode> _gameModes = [
    GameMode(
      emoji: '✏️',
      title: 'Letter Tracing',
      description: 'Trace all A to Z letters!',
      color: const Color(0xFF3852B4),
      screen: const LetterTracingScreen(),
    ),
    GameMode(
      emoji: '🔢',
      title: 'Number Tracing',
      description: 'Trace numbers 0 to 9!',
      color: const Color(0xFF4F6EB0),
      screen: const NumberTracingScreen(),
    ),
    GameMode(
      emoji: '🎨',
      title: 'Color ID',
      description: 'Can you name the color?',
      color: const Color(0xFF3852B4),
      screen: const ColorIdentificationScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3BE7A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Header
              const Text(
                'Hello!',
                style: TextStyle(
                  fontFamily: 'ABeeZee',
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'What do you want to learn today?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'ABeeZee',
                  fontSize: 20,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 40),

              // modes
              Expanded(
                child: ListView.separated(
                  itemCount: _gameModes.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final mode = _gameModes[index];
                    return GameCard(mode: mode);
                  },
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}



