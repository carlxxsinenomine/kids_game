import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kids_game/screens/well_done_screen.dart';
import 'package:tracing_game/tracing_game.dart';
import 'package:kids_game/providers/problem_provider.dart';

class LetterTracingScreen extends ConsumerStatefulWidget {
  const LetterTracingScreen({super.key});

  @override
  ConsumerState<LetterTracingScreen> createState() =>
      _NumberTracingScreenState();
}

class _NumberTracingScreenState extends ConsumerState<LetterTracingScreen> {
  int _currentLetterIndex = 0;
  bool _showNextButton = false;

  List<String> get _letters => ref.read(lettersProvider);

  List<TraceWordModel> get _currentScreenModel {
    if (_currentLetterIndex >= _letters.length) return [];

    return [
      TraceWordModel(
        word: _letters[_currentLetterIndex],
        traceShapeOptions: const TraceShapeOptions(
          innerPaintColor: Colors.orange,
        ),
      ),
    ];
  }

  void _goToNextLetter() {
    if (_currentLetterIndex + 1 < _letters.length) {
      setState(() {
        _currentLetterIndex++;
        _showNextButton = false;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => WellDoneScreen(
            score: _letters.length,
            totalRounds: _letters.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFF3BE7A),
      body: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned(
            top: 90,
            child: Text(
              "Trace the letters!",
              style: TextStyle(
                fontFamily: 'ABeeZee',
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            child: Center(
              child: Container(
                height: 380,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(0xFF3852B4).withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TracingWordGame(
                  key: ValueKey(_currentLetterIndex),
                  showAnchor: true,
                  words: _currentScreenModel,
                  onCurrentTracingScreenFinished: (screenIndex) async {},
                  onGameFinished: (screenIndex) async {
                    if (!_showNextButton) {
                      setState(() {
                        _showNextButton = true;
                      });
                    }
                  },
                  onTracingUpdated: (currentTracingIndex) async {
                    print('Traced stroke index: $currentTracingIndex');
                  },
                ),
              ),
            ),
          ),
          if (_showNextButton)
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: GestureDetector(
                onTap: _goToNextLetter,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF3852B4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 80,
                  margin: EdgeInsets.symmetric(horizontal: 60),
                  child: Center(
                    child: Text(
                      style: TextStyle(
                          fontFamily: 'ABeeZee',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70
                      ),
                      _currentLetterIndex + 1 < _letters.length
                          ? 'Next Letter'
                          : 'Finish',
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
