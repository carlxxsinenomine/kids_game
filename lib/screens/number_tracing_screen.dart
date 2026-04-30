import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kids_game/screens/well_done_screen.dart';
import 'package:tracing_game/tracing_game.dart';
import 'package:kids_game/providers/problem_provider.dart';

class NumberTracingScreen extends ConsumerStatefulWidget {
  const NumberTracingScreen({super.key});

  @override
  ConsumerState<NumberTracingScreen> createState() =>
      _NumberTracingScreenState();
}

class _NumberTracingScreenState extends ConsumerState<NumberTracingScreen> {
  int _currentNumberIndex = 0;
  bool _showNextButton = false;

  List<String> get _numbers => ref.read(numbersProvider);

  List<TraceWordModel> get _currentScreenModel {
    if (_currentNumberIndex >= _numbers.length) return [];

    return [
      TraceWordModel(
        word: _numbers[_currentNumberIndex],
        traceShapeOptions: const TraceShapeOptions(
          innerPaintColor: Colors.orange,
        ),
      ),
    ];
  }

  void _goToNextLetter() {
    if (_currentNumberIndex + 1 < _numbers.length) {
      setState(() {
        _currentNumberIndex++;
        _showNextButton = false;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => WellDoneScreen(
            score: _numbers.length,
            totalRounds: _numbers.length,
          ),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFF3BE7A),
      appBar: AppBar(
        backgroundColor: Color(0xFFF3BE7A),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 10,),
              Icon(Icons.arrow_back_ios, color: Colors.black, fontWeight: FontWeight.bold,),
              Text(
                'Back',
                style: TextStyle(fontFamily: 'ABeeZee', fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        leadingWidth: 100,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned(
            top: 90,
            child: Text(
              "Trace the numbers!",
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
                  key: ValueKey(_currentNumberIndex),
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
                        color: Colors.white70,
                      ),
                      _currentNumberIndex + 1 < _numbers.length
                          ? 'Next Number'
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
