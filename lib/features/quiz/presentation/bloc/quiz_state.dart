import 'package:equatable/equatable.dart';
import '../../domain/entities/quiz.dart';
import '../../domain/entities/quiz_question.dart';

enum QuizStatus { initial, loading, inProgress, submitted, failure }

class QuizState extends Equatable {
  final QuizStatus status;
  final Quiz? quiz;
  final int currentQuestionIndex;
  final Map<int, int> selectedAnswers;
  final String? errorMessage;
  final String? validationMessage;

  const QuizState({
    this.status = QuizStatus.initial,
    this.quiz,
    this.currentQuestionIndex = 0,
    this.selectedAnswers = const {},
    this.errorMessage,
    this.validationMessage,
  });

  QuizQuestion? get currentQuestion {
    if (quiz == null ||
        currentQuestionIndex < 0 ||
        currentQuestionIndex >= quiz!.questions.length) {
      return null;
    }
    return quiz!.questions[currentQuestionIndex];
  }

  int get totalQuestions => quiz?.questions.length ?? 0;

  int get answeredCount => selectedAnswers.length;

  List<int> get unansweredQuestions {
    if (quiz == null) return [];
    final list = <int>[];
    for (int i = 0; i < quiz!.questions.length; i++) {
      if (!selectedAnswers.containsKey(i)) {
        list.add(i + 1); // 1-based question number
      }
    }
    return list;
  }

  bool get isAllAnswered =>
      totalQuestions > 0 && selectedAnswers.length == totalQuestions;

  int get correctCount {
    if (quiz == null) return 0;
    int count = 0;
    selectedAnswers.forEach((qIndex, optionIndex) {
      if (qIndex < quiz!.questions.length) {
        if (quiz!.questions[qIndex].correctAnswerIndex == optionIndex) {
          count++;
        }
      }
    });
    return count;
  }

  int get incorrectCount => answeredCount - correctCount;

  int get score => correctCount;

  double get percentage {
    if (totalQuestions == 0) return 0.0;
    return (correctCount / totalQuestions) * 100;
  }

  bool get isSubmitted => status == QuizStatus.submitted;

  QuizState copyWith({
    QuizStatus? status,
    Quiz? quiz,
    int? currentQuestionIndex,
    Map<int, int>? selectedAnswers,
    String? errorMessage,
    String? validationMessage,
    bool clearValidationMessage = false,
  }) {
    return QuizState(
      status: status ?? this.status,
      quiz: quiz ?? this.quiz,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      errorMessage: errorMessage ?? this.errorMessage,
      validationMessage: clearValidationMessage
          ? null
          : (validationMessage ?? this.validationMessage),
    );
  }

  @override
  List<Object?> get props => [
    status,
    quiz,
    currentQuestionIndex,
    selectedAnswers,
    errorMessage,
    validationMessage,
  ];
}
