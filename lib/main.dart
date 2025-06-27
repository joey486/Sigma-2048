import 'package:flutter/material.dart';
import 'screens/game_screen.dart';

void main() {
  runApp(Sigma2048());
}

class Sigma2048 extends StatelessWidget {
  const Sigma2048({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2048 Game',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Arial'),
      home: GameScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
