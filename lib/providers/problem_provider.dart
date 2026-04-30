import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

final lettersProvider = Provider<List<String>>((ref) {
  return [
    'Aa', 'Bb', 'Cc', 'Dd', 'Ee', 'Ff', 'Gg', 'Hh', 'Ii', 'Jj', 'Kk', 'Ll', 'Mm',
    'Nn', 'Oo', 'Pp', 'Qq', 'Rr', 'Ss', 'Tt', 'Uu', 'Vv', 'Ww', 'Xx', 'Yy', 'Zz'
  ];
});

final numbersProvider = Provider<List<String>>((ref) {
  return ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
});

class GameColor {
  final String name;
  final Color color;

  const GameColor({required this.name, required this.color});
}

final colorsProvider = Provider<List<GameColor>>((ref) {
  return const [
    GameColor(name: 'Red',    color: Color(0xFFE53935)),
    GameColor(name: 'Orange', color: Color(0xFFFB8C00)),
    GameColor(name: 'Yellow', color: Color(0xFFFDD835)),
    GameColor(name: 'Green',  color: Color(0xFF43A047)),
    GameColor(name: 'Blue',   color: Color(0xFF1E88E5)),
    GameColor(name: 'Purple', color: Color(0xFF8E24AA)),
    GameColor(name: 'Pink',   color: Color(0xFFE91E93)),
    GameColor(name: 'Brown',  color: Color(0xFF6D4C41)),
    GameColor(name: 'White',  color: Color(0xFFFFFFFF)),
    GameColor(name: 'Black',  color: Color(0xFF212121)),
    GameColor(name: 'Gray',   color: Color(0xFF757575)),
    GameColor(name: 'Cyan',   color: Color(0xFF00ACC1)),
  ];
});