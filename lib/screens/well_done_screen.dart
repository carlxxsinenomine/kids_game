import 'package:flutter/material.dart';

class WellDoneScreen extends StatelessWidget {
  final int score;
  final int totalRounds;

  const WellDoneScreen({
    super.key,
    required this.score,
    required this.totalRounds,
  });

  String get _message {
    final ratio = score / totalRounds;
    if (ratio == 1.0) return 'Perfect Score!';
    if (ratio >= 0.8) return 'Amazing Job!';
    if (ratio >= 0.5) return 'Good Work!';
    return 'Keep Practicing!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3BE7A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: const Color(0xFF4F6EB0),
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text('🏅', style: TextStyle(fontSize: 72)),
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                'Well Done!',
                style: TextStyle(
                  fontFamily: 'ABeeZee',
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                _message,
                style: const TextStyle(
                  fontFamily: 'ABeeZee',
                  fontSize: 22,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 32),

              // Score card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 28),
                decoration: BoxDecoration(
                  color: const Color(0xFF4F6EB0),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Your Score',
                      style: TextStyle(
                        fontFamily: 'ABeeZee',
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$score / $totalRounds',
                      style: const TextStyle(
                        fontFamily: 'ABeeZee',
                        fontSize: 52,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: List.generate(totalRounds, (i) {
                    //     return Icon(
                    //       i < score ? Icons.star : Icons.star_border,
                    //       color: Colors.amber,
                    //       size: totalRounds > 7 ? 22 : 32,
                    //     );
                    //   }),
                    // ),
                  ],
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 64,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F6EB0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/',
                          (route) => false,
                    );
                  },
                  icon: const Icon(Icons.home_rounded,
                      color: Colors.white, size: 28),
                  label: const Text(
                    'Go Home',
                    style: TextStyle(
                      fontFamily: 'ABeeZee',
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}