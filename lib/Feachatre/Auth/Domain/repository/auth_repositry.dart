
import 'package:fpdart/fpdart.dart';

import '../../../../Core/common/entity/User.dart';
import '../../../../Core/error/Faillior.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> currentUser();
}
