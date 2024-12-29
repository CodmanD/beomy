import 'dart:io';
import 'package:crypto/crypto.dart';
import 'dart:math';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'event.dart';
import 'state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc(super.initialState) {
    // debugPrint("-----BLOC CONSTRUCT");
    // debugPrint("-----BLOC CONSTRUCT ${_auth.currentUser}");
    if (null != _auth.currentUser)
      emit(AuthorizedState(_auth.currentUser!));
    on<LoginEvent>((event, emit) async {
      // debugPrint("----BLOC ON LoginEmail ");
      //  debugPrint("----BLOC ON LoginEmail email = ${event.email}");
      emit(LoadingAuthState());
      _loginEmail(event.email, event.password);
    });

    on<GoogleLoginEvent>((event, emit) async {
      //debugPrint("----BLOC ON GoogleLogin ");
      emit(LoadingAuthState());
      if (null != _auth.currentUser) {
       // debugPrint("-----GOGLE SIGNIN USER AUTH =${_auth.currentUser}");
      } else {
        await _signInGoogle();
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(LoadingAuthState());
      await _auth.signOut().then((_) {
        // debugPrint("-----SIGN OUT SUCCES");
        emit(InitAuthState());
      }).catchError((error) {
        // debugPrint("-----SIGN OUT ERROR $error");
        emit(LogoutErrorState(error.toString()));
      });
    });

    on<FacebookLoginEvent>((event, emit) async {
      emit(LoadingAuthState());
      _loginFacebook();
    });
  }

  _loginEmail(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password).then((userCredential) {
      emit(null != userCredential.user
          ? AuthorizedState(userCredential.user!)
          : AuthErrorState("user is NULL"));
    }).catchError((error) {
      //debugPrint("-----Bloc login CATCH ERROR");
      emit(AuthErrorState('$error'));
    });
  }

  _signInGoogle() async {
    GoogleSignIn().signIn().then((account) {
      // debugPrint("-----Google SignIn succes");
      account?.authentication.then((auth) {
        // debugPrint("-----Google SignIn Auth succes");
        final credential =
            GoogleAuthProvider.credential(accessToken: auth.accessToken, idToken: auth.idToken);

        FirebaseAuth.instance.signInWithCredential(credential).then((userCredential) {
          //  debugPrint("----GoogleSignIn ALL SUCCES ${userCredential.user}");

          null != userCredential.user
              ? emit(AuthorizedState(userCredential.user!))
              : emit(AuthErrorState("user is NULL"));
        }).catchError((error) {
          //debugPrint("----GoogleSignIn 3 $error");
          emit(AuthErrorState('$error'));
        });
      }).catchError((error) {
        //debugPrint("----GoogleSignIn 2 $error");
        emit(AuthErrorState('$error'));
      });
    }).catchError((error) {
     // debugPrint("----GoogleSignIn 1 $error");
      emit(AuthErrorState('$error'));
    });
  }

  _loginFacebook() async {
    try {
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);
      final LoginResult loginResult = Platform.isIOS
          ? await FacebookAuth.instance.login(
              loginTracking: LoginTracking.limited,
              nonce: nonce,
            )
          : await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential = Platform.isIOS
          ? OAuthProvider('facebook.com').credential(
              idToken: loginResult.accessToken!.tokenString,
              rawNonce: rawNonce,
            )
          : FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      UserCredential? userCredential =
          await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      null == userCredential.user
          ? emit(AuthErrorState('user is NUll'))
          : emit(AuthorizedState(userCredential.user!));
    } catch (e) {
      print(e);
      emit(AuthErrorState(e.toString()));
    }
  }

  ///This methods for KOSTYL
  String _generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
