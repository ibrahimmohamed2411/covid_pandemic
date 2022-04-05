part of '../forgot_password_screen.dart';

class _SignInButton extends StatelessWidget {
  const _SignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return MainButton(
          title: 'Send',
          onPressed: state.forgotPasswordButtonAction(context),
        );
      },
    );
  }
}
