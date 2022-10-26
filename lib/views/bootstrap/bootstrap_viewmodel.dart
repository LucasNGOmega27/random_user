import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_user/app/locator.dart';
import 'package:random_user/services/api_service.dart';
import 'package:random_user/shared/simple_alert/simple_alert.dart';
import 'package:stacked/stacked.dart';

class BootstrapViewModel extends BaseViewModel {
  final ApiService _apiService = getIt<ApiService>();

  Future<void> getRandomUsers() async => _apiService.getRandomUsers();

  void navigateTo(BuildContext context, var route) {
    Navigator.of(context).pushReplacementNamed(route);
  }
}
