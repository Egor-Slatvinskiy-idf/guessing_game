import 'package:flutter/material.dart';
import 'package:presentation/new_bloc/new_ui/main_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreenWidget(),
    );
  }
}
