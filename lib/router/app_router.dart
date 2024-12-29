import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:beomy_login/ui/biometric_screen.dart';
import 'package:beomy_login/ui/home_screen.dart';
import 'package:beomy_login/ui/login_screen.dart';
import 'package:beomy_login/ui/start_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {

  @override
  RouteType get defaultRouteType => RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
    // HomeScreen is generated as HomeRoute because
    // of the replaceInRouteName property
    AutoRoute(page: BiometricRoute.page,path: "/"),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: StartRoute.page),
  ];

  @override
  List<AutoRouteGuard> get guards => [
    // optionally add root guards here
  ];
}