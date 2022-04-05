import 'package:bloc/bloc.dart';
import 'package:covid_pandemic/data/models/email.dart';
import 'package:covid_pandemic/data/models/password.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:provider/src/provider.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit()
      : super(const SignInState(
            email: Email.pure(''),
            password: Password.pure(''),
            hidePassword: true,
            status: FormzStatus.pure));

  void emailChanged(String newEmail) {
    final email = Email.dirty(newEmail);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String newPassword) {
    final password = Password.dirty(newPassword);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      ),
    );
  }

  void togglePassword() {
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }

  void submit() {
    if (state.status.isValid) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
    }
  }

  void revalidate() {
    var email = state.email;
    var password = state.password;
    emit(
      state.copyWith(
          email: Email.dirty(email.value),
          password: Password.dirty(password.value),
          status: Formz.validate([email, password])),
    );
  }

  void endSubmit() {
    emit(state.copyWith(status: Formz.validate([state.email, state.password])));
  }
}
