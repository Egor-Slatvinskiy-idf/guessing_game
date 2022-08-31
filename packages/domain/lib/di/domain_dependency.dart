import 'package:domain/use_case/check_use_case.dart';
import 'package:domain/use_case/generate_use_case.dart';
import 'package:get_it/get_it.dart';

void initContainerDomain() {
  GetIt.instance.registerFactory(
    () => CheckNumUseCase(),
  );
  GetIt.instance.registerFactory(
    () => GenerateNumUseCase(),
  );
}
