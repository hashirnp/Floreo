import '../entities/quiz.dart';
import '../entities/quiz_progress.dart';

abstract class QuizRepository {
  Future<Quiz> getQuiz();
  Future<QuizProgress?> getQuizProgress();
  Future<void> saveQuizProgress(QuizProgress progress);
  Future<void> clearQuizProgress();
}
