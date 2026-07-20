import 'package:equatable/equatable.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object?> get props => [];
}

class LoadQuiz extends QuizEvent {
  const LoadQuiz();
}

class SelectAnswer extends QuizEvent {
  final int questionIndex;
  final int optionIndex;

  const SelectAnswer({required this.questionIndex, required this.optionIndex});

  @override
  List<Object?> get props => [questionIndex, optionIndex];
}

class NavigateToQuestion extends QuizEvent {
  final int index;

  const NavigateToQuestion(this.index);

  @override
  List<Object?> get props => [index];
}

class GoToNextQuestion extends QuizEvent {
  const GoToNextQuestion();
}

class GoToPreviousQuestion extends QuizEvent {
  const GoToPreviousQuestion();
}

class SubmitQuiz extends QuizEvent {
  const SubmitQuiz();
}

class RestartQuiz extends QuizEvent {
  const RestartQuiz();
}
