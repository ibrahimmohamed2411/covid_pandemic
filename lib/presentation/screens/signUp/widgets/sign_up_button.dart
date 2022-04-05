part of '../sign_up_screen.dart';

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return MainButton(
          title: 'Sign Up'
              '',
          onPressed: state.signUpButtonAction(context),
        );
      },
    );
  }
}
