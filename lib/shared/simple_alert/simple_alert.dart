import 'package:flutter/material.dart';

class SimpleAlert extends StatefulWidget {
  SimpleAlert({super.key, this.alertTitle, this.alertMessage});

  final String? alertTitle;
  final String? alertMessage;
  bool checkConnection = false;
  var onPressed;

  @override
  State<SimpleAlert> createState() => _SimpleAlertState();
}

class _SimpleAlertState extends State<SimpleAlert> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(widget.alertTitle ?? ""),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(widget.alertMessage ?? ""),
              ],
            ),
          ),
          actions: <Widget>[
            // widget.checkConnection == true ?
            // TextButton(onPressed: onPressed, child: const Text("Check Connection")) : null,
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}
