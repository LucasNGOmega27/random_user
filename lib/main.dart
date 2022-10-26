import 'package:flutter/material.dart';
import 'package:random_user/app/app.dart';
import 'package:random_user/app/config.dart';
import 'package:random_user/app/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator(ConfigProfiles.dev);
  runApp(const RandomUser());
}
