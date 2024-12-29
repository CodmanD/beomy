import 'package:beomy_login/router/app_router.dart';
import 'package:beomy_login/ui/biometric_screen.dart';
import 'package:beomy_login/ui/login_screen.dart';
import 'package:beomy_login/ui/style/colors.dart';

import 'package:flutter/material.dart';

class BeomyApp extends StatelessWidget {
  BeomyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorsApp.primary),
        useMaterial3: true,
      ),
      routerConfig: _appRouter.config(),
    );
  }
}
