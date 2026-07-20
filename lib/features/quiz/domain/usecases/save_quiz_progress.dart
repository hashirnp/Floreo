import '../../../../core/usecase/usecase.dart';
import '../entities/quiz_progress.dart';
import '../repositories/quiz_repository.dart';

class SaveQuizProgress implements UseCase<void, QuizProgress> {
  final QuizRepository repository;

  SaveQuizProgress(this.repository);

  @override
  Future<void> call(QuizProgress params) async {
    await repository.saveQuizProgress(params);
  }
}
