import '../../../../core/constants/quiz_data.dart';
import '../models/quiz_model.dart';

abstract class QuizRemoteDataSource {
  Future<QuizModel> fetchQuiz();
}

class QuizRemoteDataSourceImpl implements QuizRemoteDataSource {
  @override
  Future<QuizModel> fetchQuiz() async {
    // Simulate remote network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return QuizModel.fromJson(QuizData.sampleQuizJson);
  }
}
