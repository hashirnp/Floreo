import '../../domain/entities/quiz.dart';
import 'quiz_question_model.dart';

class QuizModel extends Quiz {
  const QuizModel({
    required super.id,
    required super.title,
    required super.questions,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] as String,
      title: json['title'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((q) => QuizQuestionModel.fromJson(q as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'questions': questions
          .map((q) => QuizQuestionModel.fromEntity(q).toJson())
          .toList(),
    };
  }

  factory QuizModel.fromEntity(Quiz entity) {
    return QuizModel(
      id: entity.id,
      title: entity.title,
      questions: entity.questions,
    );
  }
}
