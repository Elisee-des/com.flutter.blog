import 'package:blog/core/secrets/app_secrets.dart';
import 'package:blog/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog/features/auth/domain/usercase/user_login.dart';
import 'package:blog/features/auth/domain/usercase/user_sign_up.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnonKey);
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  //Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )

    //Repositorye
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(serviceLocator()))

    //Usecases
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))

    //Bloc
    ..registerLazySingleton(() =>
        AuthBloc(userSignUp: serviceLocator(), userLogin: serviceLocator()));
}
