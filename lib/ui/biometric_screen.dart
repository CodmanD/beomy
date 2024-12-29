import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:beomy_login/router/app_router.dart';
import 'package:beomy_login/ui/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

@RoutePage()
class BiometricScreen extends StatefulWidget {
  const BiometricScreen({super.key});

  @override
  State<BiometricScreen> createState() => _BiometricScreenState();
}

class _BiometricScreenState extends State<BiometricScreen> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: _tapEnter,
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 2, // Me(data: data, child: child),
            decoration: BoxDecoration(
              color: ColorsApp.accentYellow,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "ENTER",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _tapEnter() async {
    bool canCheckAuth = await _localAuthentication.canCheckBiometrics;

    if (canCheckAuth) {
      bool didAuthed = await _localAuthentication.authenticate(
        localizedReason: "Please authenticate to enter the application",
      );
      if (didAuthed) {
        AutoRouter.of(context).push(StartRoute());
      } else {
        debugPrint("-----Cannot Enter");
      }
    } else {
      AutoRouter.of(context).push(StartRoute());
    }
  }
}
