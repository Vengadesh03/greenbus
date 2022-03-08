import 'package:bloodbank/core/services/api.dart';
import 'package:bloodbank/core/viewmodels/general_provider.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();
void setupLocator() {
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => GeneralProvider());
}
