import 'package:equatable/equatable.dart';

class QuizQuestion extends Equatable {
  final int id;
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  const QuizQuestion({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });

  @override
  List<Object?> get props => [
    id,
    questionText,
    options,
    correctAnswerIndex,
    explanation,
  ];
}
