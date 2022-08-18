import 'dart:math';
import 'package:flutter/material.dart';

class HomeModel {
  final numController = TextEditingController();
  bool? isGuessed;
  String? rNumber;


  String? generateNum() {
    rNumber = Random().nextInt(3).toString();
    return rNumber;
  }

  void guessed() {
    final num = numController.text;
    if(num == rNumber) {
      isGuessed = false;
    } else {
      isGuessed = true;
    }
  }
}