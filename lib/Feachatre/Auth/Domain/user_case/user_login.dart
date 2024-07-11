
import 'package:fpdart/fpdart.dart';

import '../../../../Core/common/entity/User.dart';
import '../../../../Core/error/Faillior.dart';
import '../../../../Core/usecase/use_case.dart';
import '../repository/auth_repositry.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;
  const UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
