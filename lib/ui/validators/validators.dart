import 'package:email_validator/email_validator.dart' as ev;
abstract class Validator<T> {
  final ValidatorException error;

  Validator(this.error);

  bool checkValid(T value);
}

class ValidatorException implements Exception {
  final String message;

  ValidatorException(this.message);
}


class EmailValidator implements Validator<String> {
  @override
  final ValidatorException error;

  EmailValidator(this.error);

  @override
  bool checkValid(String value) {
    return ev.EmailValidator.validate(value);
  }
}

class PasswordValidator implements Validator<String> {
  @override
  final ValidatorException error;

  PasswordValidator(this.error);

  @override
  bool checkValid(String value) {
    RegExp passwordRegExp = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+');
    return passwordRegExp.hasMatch(value);
  }
}

class ExistsEmailValidator implements Validator<String> {
  @override
  final ValidatorException error;

  final bool isEmailExists;

  ExistsEmailValidator(this.error, {required this.isEmailExists});

  @override
  bool checkValid(String value) {
    return !isEmailExists;
  }
}

class VerificationCodeValidator implements Validator<String> {
  @override
  final ValidatorException error;

  final bool invalidVerificationCode;

  VerificationCodeValidator(this.error, {required this.invalidVerificationCode});

  @override
  bool checkValid(String value) {
    return !invalidVerificationCode;
  }
}

class CurrentPasswordValidator implements Validator<String> {
  @override
  final ValidatorException error;

  final bool invalidCurrentPassword;

  CurrentPasswordValidator(this.error, {required this.invalidCurrentPassword});

  @override
  bool checkValid(String value) {
    return !invalidCurrentPassword;
  }
}

class ConfirmPasswordValidatorValidator implements Validator<String> {
  @override
  final ValidatorException error;

  final bool confirmPasswordIsNotMatched;

  ConfirmPasswordValidatorValidator(this.error, {required this.confirmPasswordIsNotMatched});

  @override
  bool checkValid(String value) {
    return !confirmPasswordIsNotMatched;
  }
}

class NewPasswordValidatorValidator implements Validator<String> {
  @override
  final ValidatorException error;

  final bool newPasswordIsMatchedWithCurrent;

  NewPasswordValidatorValidator(this.error, {required this.newPasswordIsMatchedWithCurrent});

  @override
  bool checkValid(String value) {
    return !newPasswordIsMatchedWithCurrent;
  }
}

class CorrectEmailValidator implements Validator<String> {
  @override
  final ValidatorException error;

  final bool incorrectEmail;

  CorrectEmailValidator(this.error, {required this.incorrectEmail});

  @override
  bool checkValid(String value) {
    return !incorrectEmail;
  }
}

class StringRangeValidator implements Validator<String> {
  @override
  final ValidatorException error;
  final int minLength;
  final int maxLength;

  StringRangeValidator(this.minLength, this.maxLength, this.error);

  @override
  bool checkValid(String value) {
    return value.length >= minLength && value.length <= maxLength;
  }
}

///Валидатор, проверяющий на непустое значение
class NotEmptyValidator<T> implements Validator<T> {
  @override
  final ValidatorException error;

  NotEmptyValidator({required this.error});

  @override
  bool checkValid(T value) {
    if (value is String) {
      return value.isNotEmpty;
    } else {
      return value != null;
    }
  }
}

///Check String for null or empty
bool validateString(String? value) {
  if (value == null || value.isEmpty == true) {
    return true;
  } else {
    return false;
  }
}


class DoubleRangeValidator implements Validator<double> {
  @override
  final ValidatorException error;
  final double min;
  final double max;

  DoubleRangeValidator(this.min, this.max, this.error);

  @override
  bool checkValid(double value) {
    return value >= min && value <= max;
  }
}

String requiredFieldException ='Field is required';

String stringRangeException(int min, int max) {

  String fieldShouldBe= "Field should be" ;
  String minMax=   " $min - $max " ;
  String symbols= "symbols";

  return "$fieldShouldBe $minMax $symbols";
}
String invalidEmailException ='Email format is not correct.';
String existEmailException ='Account with this email already exists.';
String emailDoesNotExistsException = "Account with this email doesn't exists.";
String invalidConfirmationCodeException = 'This code is invalid. Please re-enter';
String incorrectEmail ='Incorrect login details. Please, try again.';
String confirmPasswordIsNotMatched ="Confirm password does not match";
String passwordValidationError =
    "Password is not valid. 8-character minimum. It must include at least 1 letter and 1 digit";
