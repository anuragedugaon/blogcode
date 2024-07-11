
import 'package:fpdart/fpdart.dart';

import '../../../../Core/common/entity/User.dart';
import '../../../../Core/error/Faillior.dart';
import '../../../../Core/usecase/use_case.dart';
import '../repository/auth_repositry.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
