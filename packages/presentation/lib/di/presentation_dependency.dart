import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:presentation/di/presentation_dependency.config.dart';

@injectableInit
void initContainerPresentation(GetIt getIt) => $initGetIt(getIt);
