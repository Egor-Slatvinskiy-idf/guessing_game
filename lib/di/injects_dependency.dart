import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:presentation/di/presentation_dependency.dart';
import 'package:domain/di/domain_dependency.dart';

final getIt = GetIt.I;

@injectableInit
void injectsDependency() {
  injectsDependencyDomain(getIt);
  injectsDependencyPresentation(getIt);
}