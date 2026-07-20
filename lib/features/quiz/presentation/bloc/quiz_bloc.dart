import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/quiz_progress.dart';
import '../../domain/usecases/get_quiz.dart';
import '../../domain/usecases/get_quiz_progress.dart';
import '../../domain/usecases/reset_quiz.dart';
import '../../domain/usecases/save_quiz_progress.dart';
import 'quiz_event.dart';
import 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final GetQuiz getQuiz;
  final GetQuizProgress getQuizProgress;
  final SaveQuizProgress saveQuizProgress;
  final ResetQuiz resetQuiz;

  QuizBloc({
    required this.getQuiz,
    required this.getQuizProgress,
    required this.saveQuizProgress,
    required this.resetQuiz,
  }) : super(const QuizState()) {
    on<LoadQuiz>(_onLoadQuiz);
    on<SelectAnswer>(_onSelectAnswer);
    on<NavigateToQuestion>(_onNavigateToQuestion);
    on<GoToNextQuestion>(_onGoToNextQuestion);
    on<GoToPreviousQuestion>(_onGoToPreviousQuestion);
    on<SubmitQuiz>(_onSubmitQuiz);
    on<RestartQuiz>(_onRestartQuiz);
  }

  Future<void> _onLoadQuiz(LoadQuiz event, Emitter<QuizState> emit) async {
    emit(state.copyWith(status: QuizStatus.loading));
    try {
      final quiz = await getQuiz(const NoParams());
      final progress = await getQuizProgress(const NoParams());

      if (progress != null) {
        final status = progress.isSubmitted
            ? QuizStatus.submitted
            : QuizStatus.inProgress;
        emit(
          state.copyWith(
            status: status,
            quiz: quiz,
            currentQuestionIndex: progress.currentQuestionIndex.clamp(
              0,
              quiz.questions.length - 1,
            ),
            selectedAnswers: Map<int, int>.from(progress.selectedAnswers),
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: QuizStatus.inProgress,
            quiz: quiz,
            currentQuestionIndex: 0,
            selectedAnswers: const {},
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: QuizStatus.failure,
          errorMessage: 'Failed to load quiz: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onSelectAnswer(
    SelectAnswer event,
    Emitter<QuizState> emit,
  ) async {
    // If quiz is submitted or option already selected for this question, reject modification!
    if (state.isSubmitted ||
        state.selectedAnswers.containsKey(event.questionIndex)) {
      return;
    }

    final newAnswers = Map<int, int>.from(state.selectedAnswers);
    newAnswers[event.questionIndex] = event.optionIndex;

    final updatedState = state.copyWith(
      selectedAnswers: newAnswers,
      clearValidationMessage: true,
    );

    emit(updatedState);
    await _persistProgress(updatedState);
  }

  Future<void> _onNavigateToQuestion(
    NavigateToQuestion event,
    Emitter<QuizState> emit,
  ) async {
    if (state.quiz == null) return;
    if (event.index < 0 || event.index >= state.totalQuestions) return;

    final updatedState = state.copyWith(
      currentQuestionIndex: event.index,
      clearValidationMessage: true,
    );

    emit(updatedState);
    await _persistProgress(updatedState);
  }

  Future<void> _onGoToNextQuestion(
    GoToNextQuestion event,
    Emitter<QuizState> emit,
  ) async {
    if (state.currentQuestionIndex + 1 < state.totalQuestions) {
      add(NavigateToQuestion(state.currentQuestionIndex + 1));
    }
  }

  Future<void> _onGoToPreviousQuestion(
    GoToPreviousQuestion event,
    Emitter<QuizState> emit,
  ) async {
    if (state.currentQuestionIndex - 1 >= 0) {
      add(NavigateToQuestion(state.currentQuestionIndex - 1));
    }
  }

  Future<void> _onSubmitQuiz(SubmitQuiz event, Emitter<QuizState> emit) async {
    if (state.quiz == null) return;

    if (!state.isAllAnswered) {
      final unanswered = state.unansweredQuestions;
      String message;
      if (unanswered.length == 1) {
        message =
            'Please answer all questions before submitting. Question ${unanswered.first} is still unanswered.';
      } else if (unanswered.length <= 3) {
        final last = unanswered.last;
        final head = unanswered.sublist(0, unanswered.length - 1).join(', ');
        message =
            'Please answer all questions before submitting. Questions $head and $last are still unanswered.';
      } else {
        final firstFew = unanswered.take(3).join(', ');
        message =
            'Please answer all questions before submitting. Questions $firstFew and ${unanswered.length - 3} more are still unanswered.';
      }

      emit(state.copyWith(validationMessage: message));
      return;
    }

    final submittedState = state.copyWith(
      status: QuizStatus.submitted,
      clearValidationMessage: true,
    );

    emit(submittedState);
    await _persistProgress(submittedState);
  }

  Future<void> _onRestartQuiz(
    RestartQuiz event,
    Emitter<QuizState> emit,
  ) async {
    await resetQuiz(const NoParams());
    emit(
      state.copyWith(
        status: QuizStatus.inProgress,
        currentQuestionIndex: 0,
        selectedAnswers: const {},
        clearValidationMessage: true,
      ),
    );
  }

  Future<void> _persistProgress(QuizState currentState) async {
    final progress = QuizProgress(
      currentQuestionIndex: currentState.currentQuestionIndex,
      selectedAnswers: currentState.selectedAnswers,
      isSubmitted: currentState.isSubmitted,
    );
    await saveQuizProgress(progress);
  }
}
