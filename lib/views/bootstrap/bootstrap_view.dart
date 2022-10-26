import 'package:flutter/material.dart';
import 'package:random_user/app/locator.dart';
import 'package:random_user/app/routes.dart';
import 'package:random_user/shared/simple_alert/simple_alert.dart';
import 'package:random_user/views/bootstrap/bootstrap_viewmodel.dart';
import 'package:stacked/stacked.dart';

class BootstrapView extends StatefulWidget {
  const BootstrapView({super.key});

  @override
  State<BootstrapView> createState() => _BootstrapViewState();
}

class _BootstrapViewState extends State<BootstrapView> {
  BootstrapViewModel model = getIt<BootstrapViewModel>();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10), () {
      getIt<BootstrapViewModel>()
          .getRandomUsers()
          .then(
            (value) => model.navigateTo(context, Routes.home),
          )
          .timeout(const Duration(seconds: 8),
              onTimeout: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleAlert(
                      alertTitle: "Warning!",
                      alertMessage: "You have no internet connection",
                    );
                  }))
          .onError(
            (error, stackTrace) => showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleAlert(
                  alertTitle: "Warning!",
                  alertMessage: "Error creating a new user",
                );
              },
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BootstrapViewModel>.reactive(
      viewModelBuilder: () => BootstrapViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.white, Colors.white],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.1,
                  padding: const EdgeInsets.all(8.0),
                  child: const CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
