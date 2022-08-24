import 'package:domain/entity/number.dart';
import 'package:domain/use_case/sample_use_case/use_case_in_out.dart';

class CheckNumUseCase extends UseCaseInOut<Num, bool> {
  @override
  bool call(Num params) {
    return params.guessedNum == params.randomNum;
  }
}