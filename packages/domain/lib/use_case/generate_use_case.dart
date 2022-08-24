import 'dart:math';
import 'package:domain/use_case/sample_use_case/use_case_out.dart';

const rangeNum = 3;

class GenerateNumUseCase extends UseCaseOut<String> {
  @override
  String call() => generateNum();

  String generateNum() {
    final randomNum = Random().nextInt(rangeNum).toString();
    return randomNum;
  }
}
