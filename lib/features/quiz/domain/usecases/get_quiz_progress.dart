import '../../../../core/usecase/usecase.dart';
import '../entities/quiz_progress.dart';
import '../repositories/quiz_repository.dart';

class GetQuizProgress implements UseCase<QuizProgress?, NoParams> {
  final QuizRepository repository;

  GetQuizProgress(this.repository);

  @override
  Future<QuizProgress?> call(NoParams params) async {
    return await repository.getQuizProgress();
  }
}
