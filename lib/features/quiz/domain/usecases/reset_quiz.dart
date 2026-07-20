import '../../../../core/usecase/usecase.dart';
import '../repositories/quiz_repository.dart';

class ResetQuiz implements UseCase<void, NoParams> {
  final QuizRepository repository;

  ResetQuiz(this.repository);

  @override
  Future<void> call(NoParams params) async {
    await repository.clearQuizProgress();
  }
}
