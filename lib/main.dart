import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:covid_pandemic/logic/cubit/statistics/statistics_cubit.dart';
import 'package:covid_pandemic/presentation/routes/app_router.dart';
import 'core/constants/palette.dart';
import 'data/repositories/statistics_repository.dart';
import 'logic/cubit/articles/articles_cubit.dart';
import 'logic/cubit/authentication/authentication_cubit.dart';
import 'logic/cubit/forgotPassword/forgot_password_cubit.dart';
import 'logic/cubit/signIn/sign_in_cubit.dart';
import 'logic/cubit/signUp/sign_up_cubit.dart';
import 'logic/cubit/theme/theme_cubit.dart';
import 'logic/debug/app_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();
  runApp(const FoodApp());
}

class FoodApp extends StatelessWidget {
  const FoodApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AuthenticationCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => SignInCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => SignUpCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => ForgotPasswordCubit(),
        ),
        BlocProvider(
          lazy: false,
          create: (BuildContext context) =>
              StatisticsCubit(statisticsRepository: StatisticsRepository()),
        ),
        BlocProvider(
            create: (context) => ArticlesCubit()..getNewsByCategory('health'))
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (ctx, state) => ScreenUtilInit(
            designSize: const Size(432.0, 816.0),
            builder: () {
              return MaterialApp(
                title: 'Food App',
                theme: ThemeData(
                  //primarySwatch: Colors.blue,
                  primaryColor: Palette.primary,
                  scaffoldBackgroundColor: Palette.scaffoldColor,
                  textTheme: const TextTheme(
                    headline1: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                darkTheme: ThemeData.dark(),
                themeMode: state ? ThemeMode.dark : ThemeMode.light,
                onGenerateRoute: AppRouter.onGenerateRoute,
                // initialRoute: AppRouter.bottomNavScreen,
              );
            }),
      ),
    );
  }
}
