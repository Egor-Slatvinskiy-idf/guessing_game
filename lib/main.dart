import 'package:flutter/material.dart';
import 'package:guessed_game_labaratory_idf/di/init_container.dart';
import 'package:presentation/ui/my_app.dart';

void main() {
  initContainer();
  runApp(
    const MyApp(),
  );
}
