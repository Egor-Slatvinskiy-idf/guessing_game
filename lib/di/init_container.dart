import 'package:presentation/di/presentation_dependency.dart';
import 'package:domain/di/domain_dependency.dart';

void initContainer() {
  initContainerDomain();
  initContainerPresentation();
}