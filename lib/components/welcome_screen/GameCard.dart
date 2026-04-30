import 'package:flutter/material.dart';

import '../../models/GameMode.dart';

class GameCard extends StatelessWidget {
  final GameMode mode;

  const GameCard({required this.mode});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => mode.screen),
      ),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: mode.color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Emoji bubble
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    mode.emoji,
                    style: const TextStyle(fontSize: 36),
                  ),
                ),
              ),
            ),

            // Text
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mode.title,
                    style: const TextStyle(
                      fontFamily: 'ABeeZee',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    mode.description,
                    style: const TextStyle(
                      fontFamily: 'ABeeZee',
                      fontSize: 15,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // Arrow
            const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white70,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}