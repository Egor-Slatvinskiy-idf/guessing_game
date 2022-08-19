import 'dart:math';
import 'package:flutter/material.dart';
import 'package:untitled1/usecaseeee/usecases.dart';

class HomeModel extends ChangeNotifier {
  final useCase = ChheckNum();
  bool checkCounter = true;
  int counter = 3;
  final numController = TextEditingController();
  bool? isGuessed;
  String? rNumber;

  // HomeModel({required this.useCase});


  void updateCounter() {
    counter = 3;
    generateNum();
    checkCounter = true;
    notifyListeners();

  }

  void decrementCounter() {
    guessed();
    counter--;
    if (counter == 0) {
      checkCounter = false;
      notifyListeners();
    }
    if (counter == 3) {
      checkCounter = true;
      notifyListeners();
    }
    notifyListeners();
  }

  String? generateNum() {
    rNumber = Random().nextInt(3).toString();
    return rNumber;
  }

  void guessed() {
    final num = numController.text;

    // final params = GuessedNum(guessedNum: num, randomNum: rNumber);
    // final dssdsd = useCase(params);
    if(num == rNumber) {
      checkCounter = false;
      isGuessed = false;
    } else {
      isGuessed = true;
    }
    notifyListeners();
  }
}