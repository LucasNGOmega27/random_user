import 'package:get_it/get_it.dart';
import 'package:random_user/app/config.dart';
import 'package:random_user/services/api_service.dart';
import 'package:random_user/views/bootstrap/bootstrap_viewmodel.dart';
import 'package:random_user/views/home/home_viewmodel.dart';

GetIt getIt = GetIt.instance;

setupLocator(Config config) async {
  getIt.registerSingleton<Config>(config);

  getIt.registerSingleton<ApiService>(
      config.mockApi ? ApiService() : ApiService());

  getIt.registerFactory<BootstrapViewModel>(
    () => BootstrapViewModel(),
  );
  getIt.registerFactory<HomeViewModel>(
    () => HomeViewModel(),
  );
}
