import '../../domain/entities/quiz.dart';
import '../../domain/entities/quiz_progress.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../datasources/quiz_local_datasource.dart';
import '../datasources/quiz_remote_datasource.dart';
import '../models/quiz_progress_model.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizRemoteDataSource remoteDataSource;
  final QuizLocalDataSource localDataSource;

  QuizRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Quiz> getQuiz() async {
    try {
      final remoteQuiz = await remoteDataSource.fetchQuiz();
      await localDataSource.cacheQuiz(remoteQuiz);
      return remoteQuiz;
    } catch (_) {
      final cachedQuiz = await localDataSource.getCachedQuiz();
      if (cachedQuiz != null) {
        return cachedQuiz;
      }
      rethrow;
    }
  }

  @override
  Future<QuizProgress?> getQuizProgress() async {
    return await localDataSource.getQuizProgress();
  }

  @override
  Future<void> saveQuizProgress(QuizProgress progress) async {
    final model = QuizProgressModel.fromEntity(progress);
    await localDataSource.saveQuizProgress(model);
  }

  @override
  Future<void> clearQuizProgress() async {
    await localDataSource.clearQuizProgress();
  }
}
