import 'package:untitled1/usecase/repo.dart';
import 'package:untitled1/usecase/usecase.dart';
///extends UseCase<>
class GenerateNum {
  final NumberRepo numRepo;

  GenerateNum({required this.numRepo});

  /// передавать через <T>
  getRandomNum(int num) {
    return numRepo.generateNumUseCase(num);
  }
}