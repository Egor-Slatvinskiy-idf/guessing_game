import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:presentation/di/presentation_dependency.config.dart';

@injectableInit
void injectsDependencyPresentation(GetIt getIt) => $initGetIt(getIt);

@module
abstract class DomainUseCase {
  CheckNumUseCase();
  GenerateNumUseCase();

}

// void injectsDependencyPresentation() {
//   GetIt.instance.registerFactory<MainCubit>(
//     () => MainCubit(
//       GetIt.instance.get<GenerateNumUseCase>(),
//       GetIt.instance.get<CheckNumUseCase>(),
//     ),
//   );
// }
