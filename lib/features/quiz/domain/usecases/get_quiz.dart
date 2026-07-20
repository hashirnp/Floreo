import '../../../../core/usecase/usecase.dart';
import '../entities/quiz.dart';
import '../repositories/quiz_repository.dart';

class GetQuiz implements UseCase<Quiz, NoParams> {
  final QuizRepository repository;

  GetQuiz(this.repository);

  @override
  Future<Quiz> call(NoParams params) async {
    return await repository.getQuiz();
  }
}
