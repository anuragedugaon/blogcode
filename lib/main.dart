import 'package:blog_app/Core/Theme/theme.dart';

import 'package:blog_app/Feachatre/Auth/Persation/block/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Core/common/cubits/app_user_cubit.dart';
import 'Feachatre/Auth/Persation/Pages/SinupPage.dart';
import 'Feachatre/Auth/Persation/Pages/login_page.dart';
import 'Feachatre/blog/persention/bloc/blog_bloc.dart';
import 'Feachatre/blog/persention/pages/blog_page.dart';
import 'Feachatre/init_dependency.main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<BlogBloc>(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
           return  BlogPage();
          }
          return  LoginPage();
        },
      ),
    );
  }
}
