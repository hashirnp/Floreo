import 'package:equatable/equatable.dart';

class QuizProgress extends Equatable {
  final int currentQuestionIndex;
  final Map<int, int> selectedAnswers;
  final bool isSubmitted;

  const QuizProgress({
    required this.currentQuestionIndex,
    required this.selectedAnswers,
    required this.isSubmitted,
  });

  QuizProgress copyWith({
    int? currentQuestionIndex,
    Map<int, int>? selectedAnswers,
    bool? isSubmitted,
  }) {
    return QuizProgress(
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }

  @override
  List<Object?> get props => [
    currentQuestionIndex,
    selectedAnswers,
    isSubmitted,
  ];
}
