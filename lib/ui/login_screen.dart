import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:beomy_login/auth/bloc/bloc.dart';
import 'package:beomy_login/auth/bloc/event.dart';
import 'package:beomy_login/auth/bloc/state.dart';
import 'package:beomy_login/ui/style/colors.dart';
import 'package:beomy_login/ui/validators/validators.dart';
import 'package:beomy_login/ui/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPassVisible = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthErrorState) {
          //Show Toast after build
          WidgetsBinding.instance
              .addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  ));
        }
        return SafeArea(
          child: Scaffold(
            backgroundColor: ColorsApp.secondary,
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      (state is AuthErrorState)
                          ? Text("Login Error",
                              style: TextStyle(
                                color: ColorsApp.accentRed,
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ))
                          : (state is LoadingAuthState)
                              ? const CircularProgressIndicator(
                                  color: ColorsApp.primary,
                                )
                              : const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: ColorsApp.primary,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                      const SizedBox(height: 12),
                      TextFieldApp(
                        controller: _emailController,
                        //focusNode: FocusNode(),
                        hintText: "email",
                        inputType: TextInputType.emailAddress,
                        validators: [
                          NotEmptyValidator(
                            error: ValidatorException("required field"),
                          ),
                          StringRangeValidator(
                            2,
                            255,
                            ValidatorException(
                              stringRangeException(2, 255),
                            ),
                          ),
                          EmailValidator(
                            ValidatorException("invalid email"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFieldApp(
                        controller: _passController,
                        hintText: "password",
                        inputType: TextInputType.visiblePassword,
                        obscure: _isPassVisible,
                        suffix: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              setState(() {
                                _isPassVisible = !_isPassVisible;
                              });
                            },
                            child: SvgPicture.asset(
                              _isPassVisible
                                  ? 'assets/icons/eye_icon.svg'
                                  : 'assets/icons/eye_off.svg',
                              colorFilter:
                                  ColorFilter.mode(ColorsApp.primary, BlendMode.srcIn),
                            ),
                          ),
                        ),
                        validators: [
                          NotEmptyValidator(
                            error: ValidatorException("required field"),
                          ),
                          StringRangeValidator(
                            8,
                            64,
                            ValidatorException(
                              stringRangeException(8, 64),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            context
                                .read<AuthBloc>()
                                .add(LoginEvent(_emailController.text, _passController.text));
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            color: ColorsApp.primary,
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                // color: ColorsApp.secondary,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                context.read<AuthBloc>().add(GoogleLoginEvent());
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 20),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: ColorsApp.primary,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                child: SvgPicture.asset(
                                  "assets/icons/google_icon.svg",
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Flexible(
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                context.read<AuthBloc>().add(FacebookLoginEvent());
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: ColorsApp.primary.withAlpha(8),
                                  border: Border.all(
                                    color: ColorsApp.primary,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                child: SvgPicture.asset(
                                  "assets/icons/facebook.svg",
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
