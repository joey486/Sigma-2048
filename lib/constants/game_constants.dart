import 'package:flutter/material.dart';

class GameConstants {
  static const int boardSize = 4;
  static const int winningTile = 2048;
  static const Duration moveAnimationDuration = Duration(milliseconds: 550);
  static const Duration scaleAnimationDuration = Duration(milliseconds: 300);

  // Colors
  static const Color backgroundColor = Color(0xFFFAF8EF);
  static const Color appBarColor = Color(0xFF8F7A66);
  static const Color boardColor = Color(0xFFBBADA0);
  static const Color emptyCellColor = Color(0xFFCDC1B4);
  static const Color darkTextColor = Color(0xFF776E65);

  static const Map<int, Color> tileColors = {
    0: Color(0xFFCDC1B4),
    2: Color(0xFFEEE4DA),
    4: Color(0xFFEDE0C8),
    8: Color(0xFFF2B179),
    16: Color(0xFFF59563),
    32: Color(0xFFF67C5F),
    64: Color(0xFFF65E3B),
    128: Color(0xFFEDCF72),
    256: Color(0xFFEDCC61),
    512: Color(0xFFEDC850),
    1024: Color(0xFFEDC53F),
    2048: Color(0xFFEDC22E),
    4096: Color.fromARGB(255, 250, 192, 2),
    8192: Color.fromARGB(255, 0, 0, 0),
  };
}
