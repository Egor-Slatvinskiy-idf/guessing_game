import 'package:domain/entity/game_numbers.dart';
import 'package:domain/use_case/sample_use_case/use_case_in_out.dart';

class CheckNumUseCase extends UseCaseInOut<GameNumbers, bool> {
  @override
  bool call(GameNumbers params) {
    return params.enteredNum == params.randomNum;
  }
}