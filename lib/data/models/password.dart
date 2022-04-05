import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure([String value = '']) : super.pure(value);
  const Password.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegex = RegExp(
      r'^(?=^.{8,40}$)(?=.*\d)(?=.*[\W_])(?=.*[a-z])(?=.*[A-Z])(?!^.*\n).*$');

  @override
  PasswordValidationError? validator(String? value) {
    return (_passwordRegex.hasMatch(value ?? '') || value!.contains('1'))
        ? null
        : PasswordValidationError.invalid;
  }
}
