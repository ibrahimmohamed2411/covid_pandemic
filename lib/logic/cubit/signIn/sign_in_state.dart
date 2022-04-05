part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  final Email email;
  final Password password;
  final bool hidePassword;
  final FormzStatus status;

  const SignInState(
      {required this.email,
      required this.password,
      required this.hidePassword,
      required this.status});

  Function()? signInButtonAction(BuildContext context) {
    if (status.isValid) {
      return context.read<SignInCubit>().submit;
    } else if (status.isPure || status.isInvalid) {
      return context.read<SignInCubit>().revalidate;
    } else if (status.isSubmissionInProgress) {
      return null;
    }
  }

  SignInState copyWith(
      {Email? email,
      Password? password,
      bool? hidePassword,
      FormzStatus? status}) {
    return SignInState(
        email: email ?? this.email,
        password: password ?? this.password,
        hidePassword: hidePassword ?? this.hidePassword,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [email, password, hidePassword, status];

  @override
  String toString() {
    return 'email: $email, password: $password, showPassword: $hidePassword, status: $status';
  }
}
