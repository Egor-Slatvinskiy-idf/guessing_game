import 'package:flutter/material.dart';
import 'package:guessed_game_labaratory_idf/di/injects_dependency.dart';
import 'package:presentation/ui/my_app.dart';

void main() {
  injectsDependency();
  runApp(
    const MyApp(),
  );
}
