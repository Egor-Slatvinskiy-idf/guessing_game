import 'package:domain/di/domain_dependency.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';


@InjectableInit()
void injectsDependencyDomain(GetIt getIt) => $initGetIt(getIt);

