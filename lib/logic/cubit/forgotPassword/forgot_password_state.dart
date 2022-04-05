part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  final Email email;
  final FormzStatus status;

  const ForgotPasswordState({required this.email, required this.status});

  ForgotPasswordState copyWith({Email? email, FormzStatus? status}) =>
      ForgotPasswordState(
          email: email ?? this.email, status: status ?? this.status);

  Function()? forgotPasswordButtonAction(BuildContext context) {
    if (status.isValid) {
      return context.read<ForgotPasswordCubit>().submit;
    } else if (status.isPure || status.isInvalid) {
      return context.read<ForgotPasswordCubit>().revalidate;
    } else if (status.isSubmissionInProgress) {
      return null;
    }
  }

  @override
  List<Object?> get props => [email, status];
}
