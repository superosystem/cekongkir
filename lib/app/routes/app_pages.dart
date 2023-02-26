import 'package:cekongkir/app/modules/home/binding/home_binding.dart';
import 'package:cekongkir/app/modules/home/views/HomeView.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
}

abstract class _Paths {
  static const HOME = '/home';
}
