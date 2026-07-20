import 'package:equatable/equatable.dart';
import 'quiz_question.dart';

class Quiz extends Equatable {
  final String id;
  final String title;
  final List<QuizQuestion> questions;

  const Quiz({required this.id, required this.title, required this.questions});

  @override
  List<Object?> get props => [id, title, questions];
}
