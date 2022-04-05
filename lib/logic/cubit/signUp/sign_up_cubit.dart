import 'package:bloc/bloc.dart';
import 'package:covid_pandemic/data/models/email.dart';
import 'package:covid_pandemic/data/models/name.dart';
import 'package:covid_pandemic/data/models/password.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:provider/src/provider.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit()
      : super(const SignUpState(
            name: Name.pure(),
            email: Email.pure(''),
            //location: Name.pure(),
            password: Password.pure(''),
            hidePassword: true,
            status: FormzStatus.invalid));

  void nameChanged(String newName) {
    final name = Name.dirty(newName);
    emit(
      state.copyWith(
        name: name,
        status: Formz.validate([name, state.email, state.password]),
      ),
    );
  }

  void emailChanged(String newEmail) {
    final email = Email.dirty(newEmail);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([state.name, email, state.password]),
    ));
  }

  // void locationChanged(String newLocation) {
  //   final location = Name.dirty(newLocation);
  //   emit(state.copyWith(
  //     location: location,
  //     status:
  //         Formz.validate([state.name, state.email, location, state.password]),
  //   ));
  // }

  void passwordChanged(String newPassword) {
    final password = Password.dirty(newPassword);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.name, state.email, password]),
    ));
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
    var name = state.name;
    var email = state.email;
    var password = state.password;
    emit(
      state.copyWith(
          name: Name.dirty(name.value),
          email: Email.dirty(email.value),
          password: Password.dirty(password.value),
          status: Formz.validate([name, email, password])),
    );
  }

  void endSubmit() {
    emit(state.copyWith(status: FormzStatus.valid));
  }
}
