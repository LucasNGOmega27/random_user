import 'package:flutter/material.dart';
import 'package:random_user/views/bootstrap/bootstrap_view.dart';
import 'package:random_user/views/home/home_view.dart';

class Routes {
  static const String home = '/home';
  static const String bootstrap = '/bootstrap';

  static final Map<String, Widget Function(BuildContext)> map = {
    bootstrap: (context) => const BootstrapView(),
    home: (context) => const HomeView(),
  };
}
