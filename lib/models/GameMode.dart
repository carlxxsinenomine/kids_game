import 'package:flutter/cupertino.dart';

class GameMode {
  final String emoji;
  final String title;
  final String description;
  final Color color;
  final Widget screen;

  const GameMode({
    required this.emoji,
    required this.title,
    required this.description,
    required this.color,
    required this.screen,
  });
}