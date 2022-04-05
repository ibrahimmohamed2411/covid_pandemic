import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:formz/formz.dart';
import 'package:covid_pandemic/core/constants/styles.dart';
import 'package:covid_pandemic/logic/cubit/authentication/authentication_cubit.dart';
import 'package:covid_pandemic/logic/cubit/signUp/sign_up_cubit.dart';
import 'package:covid_pandemic/presentation/widgets/auth_circular_progress.dart';
import 'package:covid_pandemic/presentation/widgets/custom_card.dart';
import 'package:covid_pandemic/presentation/widgets/custom_text_field.dart';
import 'package:covid_pandemic/presentation/widgets/google_outlined_button.dart';
import 'package:covid_pandemic/presentation/widgets/main_button.dart';

part 'widgets/name_input.dart';

part 'widgets/email_input.dart';

// part 'widgets/location_input.dart';

part 'widgets/password_input.dart';

part 'widgets/sign_up_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //resizeToAvoidBottomInset: false,
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthenticationCubit, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationSuccess) {
                // AwesomeDialog(
                //   context: context,
                //   animType: AnimType.SCALE,
                //   dialogType: DialogType.SUCCES,
                //   title: 'Success',
                //   desc:
                //       'You will shortly receive an email to setup a new password',
                //   btnOkOnPress: () {},
                // ).show();

                context.read<SignUpCubit>().endSubmit();
                Navigator.of(context).pop();
              } else if (state is AuthenticationError) {
                // AwesomeDialog(
                //   context: context,
                //   animType: AnimType.SCALE,
                //   dialogType: DialogType.ERROR,
                //   title: 'Sorry',
                //   desc: state.message,
                //   btnOkOnPress: () {},
                // ).show();

                context.read<SignUpCubit>().endSubmit();
              }
            },
          ),
          BlocListener<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if (state.status == FormzStatus.submissionInProgress) {
                context
                    .read<AuthenticationCubit>()
                    .signUp(state.email.value, state.password.value);
              }
            },
          ),
        ],
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                top: 56.h,
                left: 15.w,
                right: 15.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    child: Text(
                      'Sign Up',
                      style: Styles.title1,
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  CustomCard(
                    children: [
                      const _NameInput(),
                      SizedBox(
                        height: 15.h,
                      ),
                      const _EmailInput(),
                      SizedBox(
                        height: 15.h,
                      ),
                      //const _LocationInput(),
                      SizedBox(
                        height: 15.h,
                      ),
                      const _PasswordInput(),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const AuthCircularProgress(),
                  const _SignUpButton(),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Do you have an account?',
                        style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GoogleOutLinedButton(
                    text: 'Sign Up With Google',
                    onPressed: () async {
                      await BlocProvider.of<AuthenticationCubit>(context)
                          .logInWithGoogle();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
