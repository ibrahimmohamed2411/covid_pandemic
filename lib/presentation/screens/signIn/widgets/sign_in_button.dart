part of '../sign_in_screen.dart';

class _SignInButton extends StatelessWidget {
  const _SignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return MainButton(
          title: 'Sign In',
          onPressed: state.signInButtonAction(context),
        );
      },
    );
  }
}
