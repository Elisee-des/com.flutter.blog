import 'package:blog/core/error/faillures.dart';
import 'package:blog/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> loginUpWithEmailPassword({
    required String email,
    required String password,
  });
}
