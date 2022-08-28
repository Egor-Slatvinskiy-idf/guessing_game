import 'package:domain/use_case/check_use_case.dart';
import 'package:domain/use_case/generate_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/new_cubit/cubit/main_cubit.dart';

void implDependencyPresentation() {
  GetIt.instance.registerFactory<MainCubit>(
    () => MainCubit(
      GetIt.instance.get<GenerateNumUseCase>(),
      GetIt.instance.get<CheckNumUseCase>(),
    ),
  );
}
