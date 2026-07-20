import '../../domain/entities/quiz_question.dart';

class QuizQuestionModel extends QuizQuestion {
  const QuizQuestionModel({
    required super.id,
    required super.questionText,
    required super.options,
    required super.correctAnswerIndex,
    required super.explanation,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    return QuizQuestionModel(
      id: json['id'] as int,
      questionText: json['questionText'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      correctAnswerIndex: json['correctAnswerIndex'] as int,
      explanation: json['explanation'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionText': questionText,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
      'explanation': explanation,
    };
  }

  factory QuizQuestionModel.fromEntity(QuizQuestion entity) {
    return QuizQuestionModel(
      id: entity.id,
      questionText: entity.questionText,
      options: entity.options,
      correctAnswerIndex: entity.correctAnswerIndex,
      explanation: entity.explanation,
    );
  }
}
