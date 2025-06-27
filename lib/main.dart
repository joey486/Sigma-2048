import 'package:flutter/material.dart';
import 'screens/game_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
