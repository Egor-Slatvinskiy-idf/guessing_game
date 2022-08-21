import 'package:domain/usecase/sample_usecase/usecase_in_out.dart';
import '../entity/number.dart';

class CheckNumUseCase extends UseCaseInOut<Num, bool> {
  @override
  bool call(Num params) {
    return params.guessedNum == params.randomNum;
  }
}