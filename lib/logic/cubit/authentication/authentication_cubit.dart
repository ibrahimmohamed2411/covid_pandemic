import 'package:bloc/bloc.dart';
import 'package:covid_pandemic/data/models/email.dart';
import 'package:covid_pandemic/data/models/password.dart';
import 'package:covid_pandemic/data/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  AuthenticationCubit() : super(AuthenticationInitial());

  Future<void> logInWithCredentials(Email email, Password password) async {
    emit(AuthenticationInProgress());
    try {
      await _authenticationRepository.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      emit(AuthenticationSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthenticationError(message: e.message!));
    }
  }

  Future<void> logInWithGoogle() async {
    emit(AuthenticationInProgress());
    try {
      await _authenticationRepository.signWithGoogle();
      emit(AuthenticationSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthenticationError(message: e.message!));
    }
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(AuthenticationInProgress());
    try {
      await _authenticationRepository.createUserWithEmailAndPassword(
          email, password);
      emit(AuthenticationSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthenticationError(message: e.message!));
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      emit(AuthenticationInProgress());
      await _authenticationRepository.signUp(email, password);
      emit(AuthenticationSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthenticationError(message: e.message!));
    }
  }

  Future<void> signOut() async {
    await _authenticationRepository.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _authenticationRepository.sendPasswordResetEmail(email);
      emit(AuthenticationSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthenticationError(message: e.message!));
    }
  }

  Future<void> signInAnounymous() async {
    emit(AuthenticationInProgress());
    await _authenticationRepository.signInAnonymous();
    emit(AuthenticationSuccess());
  }
}
