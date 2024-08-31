import 'package:blog/core/secrets/app_secrets.dart';
import 'package:blog/core/theme/theme.dart';
import 'package:blog/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog/features/auth/data/usercase/user_sign_up.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/auth/presentation/pages/login_page.dart';
import 'package:blog/features/auth/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnonKey);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
              userSignUp: UserSignUp(AuthRepositoryImpl(
                  AuthRemoteDataSourceImpl(supabaseClient: supabase.client)))),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
