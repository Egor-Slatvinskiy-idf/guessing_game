import 'dart:math';
import 'package:domain/usecase/sample_usecase/usecase_out.dart';

class GenerateNumUseCase extends UseCaseOut<String> {
  @override
  String call() => generateNum();

  String generateNum() {
    final rNumber = Random().nextInt(3).toString();
    return rNumber;
  }
}
