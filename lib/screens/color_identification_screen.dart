import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kids_game/screens/well_done_screen.dart';
import '../providers/problem_provider.dart';
import 'dart:math';

class ColorIdentificationScreen extends ConsumerStatefulWidget {
  const ColorIdentificationScreen({super.key});

  @override
  ConsumerState<ColorIdentificationScreen> createState() =>
      _ColorIdentificationScreenState();
}

class _ColorIdentificationScreenState
    extends ConsumerState<ColorIdentificationScreen> {
  late GameColor _targetColor;
  late List<GameColor> _choices;
  final Set<String> _usedColors = {};

  String? _selectedAnswer;
  bool _answered = false;
  int _score = 0;
  int _round = 0;
  final int _totalRounds = 10;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _nextRound());
  }

  void _nextRound() {
    final colors = ref.read(colorsProvider);
    final random = Random();

    final available = colors.where((c) => !_usedColors.contains(c.name)).toList();

    if (available.isEmpty) {
      _showResultDialog();
      return;
    }

    final target = available[random.nextInt(available.length)];
    _usedColors.add(target.name);

    final others = List<GameColor>.from(colors)
      ..removeWhere((c) => c.name == target.name)
      ..shuffle();
    final wrongs = others.take(3).toList();

    final allChoices = [...wrongs, target]..shuffle();

    setState(() {
      _targetColor = target;
      _choices = allChoices;
      _selectedAnswer = null;
      _answered = false;
    });
  }

  void _handleAnswer(String answer) {
    if (_answered) return;
    final isCorrect = answer == _targetColor.name;

    setState(() {
      _selectedAnswer = answer;
      _answered = true;
      if (isCorrect) _score++;
      _round++;
    });
  }

  void _showResultDialog() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => WellDoneScreen(
          score: _score,
          totalRounds: _totalRounds,
        ),
      ),
    );
  }

  Color _getChoiceColor(String choiceName) {
    if (!_answered) return const Color(0xFF4F6EB0);
    if (choiceName == _targetColor.name) return Colors.green;
    if (choiceName == _selectedAnswer) return Colors.red;
    return const Color(0xFF4F6EB0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3BE7A),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 10,),
              Icon(Icons.arrow_back_ios, color: Colors.black, fontWeight: FontWeight.bold,),
              Text('Back',
                  style: TextStyle(fontFamily: 'ABeeZee', fontSize: 28, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        leadingWidth: 100,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'Score $_score / $_totalRounds',
                style:
                const TextStyle(fontFamily: 'ABeeZee', fontSize: 18, fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF3BE7A),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            const Text(
              'What color is this?',
              style: TextStyle(
                  fontFamily: 'ABeeZee',
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: const Color(0xFF4F6EB0),
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4))
                ],
              ),
              child: Center(
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: _targetColor.color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4))
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 42),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
              children: _choices.map((choice) {
                return GestureDetector(
                  onTap: () => _handleAnswer(choice.name),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: _getChoiceColor(choice.name),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2))
                      ],
                    ),
                    child: Center(
                      child: Text(
                        choice.name,
                        style: const TextStyle(
                          fontFamily: 'ABeeZee',
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const Spacer(),

            if (_answered)
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F6EB0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    if (_round >= _totalRounds) {
                      _showResultDialog();
                    } else {
                      _nextRound();
                    }
                  },
                  child: Text(
                    _round >= _totalRounds ? 'See Results' : 'Next Color',
                    style: const TextStyle(
                        fontFamily: 'ABeeZee',
                        fontSize: 22,
                        color: Colors.white),
                  ),
                ),
              ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}