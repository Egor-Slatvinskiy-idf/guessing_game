import 'package:get_it/get_it.dart';
import 'package:presentation/di/presentation_dependency.dart';
import 'package:domain/di/domain_dependency.dart';

final getIt = GetIt.I;

void initContainer() {
  initContainerDomain(getIt);
  initContainerPresentation(getIt);
}