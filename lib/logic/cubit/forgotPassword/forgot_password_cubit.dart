import 'package:bloc/bloc.dart';
import 'package:covid_pandemic/data/models/email.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:provider/src/provider.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit()
      : super(const ForgotPasswordState(
            email: Email.pure(), status: FormzStatus.pure));

  void emailChanged(String newEmail) {
    final email = Email.dirty(newEmail);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email]),
      ),
    );
  }

  void submit() {
    if (state.status.isValid) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
    }
  }

  void revalidate() {
    var email = state.email;
    emit(
      state.copyWith(
          email: Email.dirty(email.value),
          status: Formz.validate([
            email,
          ])),
    );
  }

  void endSubmit() {
    emit(state.copyWith(status: Formz.validate([state.email])));
  }
}
