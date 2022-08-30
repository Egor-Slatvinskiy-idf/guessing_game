import 'package:domain/entity/copy_numbers.dart';
import 'package:domain/use_case/sample_use_case/use_case_in_out.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckNumUseCase extends UseCaseInOut<CopyNumbers, bool> {
  @override
  bool call(CopyNumbers params) {
    return params.enteredNum == params.randomNum;
  }
}