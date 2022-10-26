import 'package:flutter/material.dart';
import 'package:random_user/app/config.dart';
import 'package:random_user/app/routes.dart';

class RandomUser extends StatelessWidget {
  const RandomUser({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Random User',
        routes: Routes.map,
        initialRoute: Routes.bootstrap,
        theme:
            ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.white),
        debugShowCheckedModeBanner:
            ConfigProfiles.dev.flag == true ? true : false,
      );
}
