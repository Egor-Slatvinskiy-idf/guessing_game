import 'package:domain/entity/parameters_check.dart';
import 'package:domain/use_case/sample_use_case/use_case_in_out.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckNumUseCase extends UseCaseInOut<ParametersToCheck, bool> {
  @override
  bool call(ParametersToCheck params) {
    return params.enteredNum == params.randomNum;
  }
}