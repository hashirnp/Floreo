import '../../domain/entities/quiz_progress.dart';

class QuizProgressModel extends QuizProgress {
  const QuizProgressModel({
    required super.currentQuestionIndex,
    required super.selectedAnswers,
    required super.isSubmitted,
  });

  factory QuizProgressModel.fromJson(Map<String, dynamic> json) {
    final rawAnswers = json['selectedAnswers'] as Map<dynamic, dynamic>? ?? {};
    final Map<int, int> selectedAnswersMap = {};
    rawAnswers.forEach((key, value) {
      final intKey = int.parse(key.toString());
      final intVal = int.parse(value.toString());
      selectedAnswersMap[intKey] = intVal;
    });

    return QuizProgressModel(
      currentQuestionIndex: json['currentQuestionIndex'] as int? ?? 0,
      selectedAnswers: selectedAnswersMap,
      isSubmitted: json['isSubmitted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, int> stringKeyAnswers = {};
    selectedAnswers.forEach((key, value) {
      stringKeyAnswers[key.toString()] = value;
    });

    return {
      'currentQuestionIndex': currentQuestionIndex,
      'selectedAnswers': stringKeyAnswers,
      'isSubmitted': isSubmitted,
    };
  }

  factory QuizProgressModel.fromEntity(QuizProgress entity) {
    return QuizProgressModel(
      currentQuestionIndex: entity.currentQuestionIndex,
      selectedAnswers: entity.selectedAnswers,
      isSubmitted: entity.isSubmitted,
    );
  }
}
