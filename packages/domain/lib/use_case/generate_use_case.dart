import 'dart:math';
import 'package:domain/use_case/sample_use_case/use_case_out.dart';
import 'package:injectable/injectable.dart';

const rangeNum = 3;

@injectable
class GenerateNumUseCase extends UseCaseOut<String> {
  @override
  String call() => generateNum();

  String generateNum() {
    final randomNum = Random().nextInt(rangeNum).toString();
    return randomNum;
  }
}
