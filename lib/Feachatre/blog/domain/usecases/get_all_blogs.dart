import 'package:fpdart/fpdart.dart';
import '../../../../Core/error/Faillior.dart';
import '../../../../Core/usecase/use_case.dart';
import '../enitty/blog.dart';
import '../repositotry/blog_repositroy.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;
  GetAllBlogs(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
