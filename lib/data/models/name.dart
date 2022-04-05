import 'package:formz/formz.dart';

enum EmailValidationError { invalid }

class Name extends FormzInput<String, EmailValidationError> {
  const Name.pure([String value = '']) : super.pure(value);
  const Name.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String? value) {
    return value!.isNotEmpty ? null : EmailValidationError.invalid;
  }
}
