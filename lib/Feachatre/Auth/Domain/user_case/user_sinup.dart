
import 'package:fpdart/fpdart.dart';

import '../../../../Core/common/entity/User.dart';
import '../../../../Core/error/Faillior.dart';
import '../../../../Core/usecase/use_case.dart';
import '../repository/auth_repositry.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;
  UserSignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
