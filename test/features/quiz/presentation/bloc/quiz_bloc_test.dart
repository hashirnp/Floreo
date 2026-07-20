import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:floreo/core/usecase/usecase.dart';
import 'package:floreo/features/quiz/domain/entities/quiz.dart';
import 'package:floreo/features/quiz/domain/entities/quiz_progress.dart';
import 'package:floreo/features/quiz/domain/entities/quiz_question.dart';
import 'package:floreo/features/quiz/domain/usecases/get_quiz.dart';
import 'package:floreo/features/quiz/domain/usecases/get_quiz_progress.dart';
import 'package:floreo/features/quiz/domain/usecases/reset_quiz.dart';
import 'package:floreo/features/quiz/domain/usecases/save_quiz_progress.dart';
import 'package:floreo/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:floreo/features/quiz/presentation/bloc/quiz_event.dart';
import 'package:floreo/features/quiz/presentation/bloc/quiz_state.dart';

class MockGetQuiz extends Mock implements GetQuiz {}

class MockGetQuizProgress extends Mock implements GetQuizProgress {}

class MockSaveQuizProgress extends Mock implements SaveQuizProgress {}

class MockResetQuiz extends Mock implements ResetQuiz {}

void main() {
  late QuizBloc quizBloc;
  late MockGetQuiz mockGetQuiz;
  late MockGetQuizProgress mockGetQuizProgress;
  late MockSaveQuizProgress mockSaveQuizProgress;
  late MockResetQuiz mockResetQuiz;

  const tQuiz = Quiz(
    id: 'test_quiz',
    title: 'Test Quiz',
    questions: [
      QuizQuestion(
        id: 1,
        questionText: 'Question 1',
        options: ['A', 'B', 'C', 'D'],
        correctAnswerIndex: 1, // B is correct
        explanation: 'Exp 1',
      ),
      QuizQuestion(
        id: 2,
        questionText: 'Question 2',
        options: ['A', 'B', 'C', 'D'],
        correctAnswerIndex: 0, // A is correct
        explanation: 'Exp 2',
      ),
    ],
  );

  setUpAll(() {
    registerFallbackValue(const NoParams());
    registerFallbackValue(
      const QuizProgress(
        currentQuestionIndex: 0,
        selectedAnswers: {},
        isSubmitted: false,
      ),
    );
  });

  setUp(() {
    mockGetQuiz = MockGetQuiz();
    mockGetQuizProgress = MockGetQuizProgress();
    mockSaveQuizProgress = MockSaveQuizProgress();
    mockResetQuiz = MockResetQuiz();

    when(() => mockGetQuiz(any())).thenAnswer((_) async => tQuiz);
    when(() => mockGetQuizProgress(any())).thenAnswer((_) async => null);
    when(() => mockSaveQuizProgress(any())).thenAnswer((_) async {});
    when(() => mockResetQuiz(any())).thenAnswer((_) async {});

    quizBloc = QuizBloc(
      getQuiz: mockGetQuiz,
      getQuizProgress: mockGetQuizProgress,
      saveQuizProgress: mockSaveQuizProgress,
      resetQuiz: mockResetQuiz,
    );
  });

  tearDown(() {
    quizBloc.close();
  });

  test('initial state should be QuizState() with initial status', () {
    expect(quizBloc.state.status, equals(QuizStatus.initial));
  });

  group('LoadQuiz', () {
    blocTest<QuizBloc, QuizState>(
      'emits [loading, inProgress] with quiz when LoadQuiz is added and no prior progress exists',
      build: () => quizBloc,
      act: (bloc) => bloc.add(const LoadQuiz()),
      expect: () => [
        const QuizState(status: QuizStatus.loading),
        const QuizState(
          status: QuizStatus.inProgress,
          quiz: tQuiz,
          currentQuestionIndex: 0,
          selectedAnswers: {},
        ),
      ],
    );

    blocTest<QuizBloc, QuizState>(
      'restores saved progress when prior progress exists',
      build: () {
        when(() => mockGetQuizProgress(any())).thenAnswer(
          (_) async => const QuizProgress(
            currentQuestionIndex: 1,
            selectedAnswers: {0: 1},
            isSubmitted: false,
          ),
        );
        return quizBloc;
      },
      act: (bloc) => bloc.add(const LoadQuiz()),
      expect: () => [
        const QuizState(status: QuizStatus.loading),
        const QuizState(
          status: QuizStatus.inProgress,
          quiz: tQuiz,
          currentQuestionIndex: 1,
          selectedAnswers: {0: 1},
        ),
      ],
    );
  });

  group('SelectAnswer and Answer Locking', () {
    blocTest<QuizBloc, QuizState>(
      'selects an answer and saves progress',
      build: () => quizBloc,
      seed: () => const QuizState(
        status: QuizStatus.inProgress,
        quiz: tQuiz,
        currentQuestionIndex: 0,
        selectedAnswers: {},
      ),
      act: (bloc) =>
          bloc.add(const SelectAnswer(questionIndex: 0, optionIndex: 1)),
      expect: () => [
        const QuizState(
          status: QuizStatus.inProgress,
          quiz: tQuiz,
          currentQuestionIndex: 0,
          selectedAnswers: {0: 1},
        ),
      ],
      verify: (_) {
        verify(() => mockSaveQuizProgress(any())).called(1);
      },
    );

    blocTest<QuizBloc, QuizState>(
      'REJECTS changing an answer once an answer is locked for that question',
      build: () => quizBloc,
      seed: () => const QuizState(
        status: QuizStatus.inProgress,
        quiz: tQuiz,
        currentQuestionIndex: 0,
        selectedAnswers: {0: 1}, // Option B (index 1) is already locked!
      ),
      act: (bloc) => bloc.add(
        const SelectAnswer(questionIndex: 0, optionIndex: 2),
      ), // Attempt to pick Option C
      expect: () =>
          [], // Expect NO state emission because change is locked out!
    );
  });

  group('Navigation', () {
    blocTest<QuizBloc, QuizState>(
      'navigates to specified question index',
      build: () => quizBloc,
      seed: () => const QuizState(
        status: QuizStatus.inProgress,
        quiz: tQuiz,
        currentQuestionIndex: 0,
      ),
      act: (bloc) => bloc.add(const NavigateToQuestion(1)),
      expect: () => [
        const QuizState(
          status: QuizStatus.inProgress,
          quiz: tQuiz,
          currentQuestionIndex: 1,
        ),
      ],
    );

    blocTest<QuizBloc, QuizState>(
      'ignores navigation out of bounds',
      build: () => quizBloc,
      seed: () => const QuizState(
        status: QuizStatus.inProgress,
        quiz: tQuiz,
        currentQuestionIndex: 0,
      ),
      act: (bloc) => bloc.add(const NavigateToQuestion(5)),
      expect: () => [],
    );
  });

  group('SubmitQuiz Validation & Score Calculation', () {
    blocTest<QuizBloc, QuizState>(
      'BLOCKS submission when questions remain unanswered and sets validationMessage',
      build: () => quizBloc,
      seed: () => const QuizState(
        status: QuizStatus.inProgress,
        quiz: tQuiz,
        currentQuestionIndex: 0,
        selectedAnswers: {0: 1}, // Question 2 (index 1) is unanswered!
      ),
      act: (bloc) => bloc.add(const SubmitQuiz()),
      expect: () => [
        const QuizState(
          status: QuizStatus.inProgress,
          quiz: tQuiz,
          currentQuestionIndex: 0,
          selectedAnswers: {0: 1},
          validationMessage:
              'Please answer all questions before submitting. Question 2 is still unanswered.',
        ),
      ],
    );

    blocTest<QuizBloc, QuizState>(
      'allows submission when ALL questions are answered, calculating correct score and percentage',
      build: () => quizBloc,
      seed: () => const QuizState(
        status: QuizStatus.inProgress,
        quiz: tQuiz,
        currentQuestionIndex: 1,
        selectedAnswers: {
          0: 1,
          1: 0,
        }, // Both Q1 (B - correct) & Q2 (A - correct) answered!
      ),
      act: (bloc) => bloc.add(const SubmitQuiz()),
      expect: () => [
        const QuizState(
          status: QuizStatus.submitted,
          quiz: tQuiz,
          currentQuestionIndex: 1,
          selectedAnswers: {0: 1, 1: 0},
        ),
      ],
      verify: (bloc) {
        expect(bloc.state.correctCount, equals(2));
        expect(bloc.state.incorrectCount, equals(0));
        expect(bloc.state.percentage, equals(100.0));
        verify(() => mockSaveQuizProgress(any())).called(1);
      },
    );
  });

  group('RestartQuiz', () {
    blocTest<QuizBloc, QuizState>(
      'clears storage progress and resets state to fresh inProgress',
      build: () => quizBloc,
      seed: () => const QuizState(
        status: QuizStatus.submitted,
        quiz: tQuiz,
        currentQuestionIndex: 1,
        selectedAnswers: {0: 1, 1: 0},
      ),
      act: (bloc) => bloc.add(const RestartQuiz()),
      expect: () => [
        const QuizState(
          status: QuizStatus.inProgress,
          quiz: tQuiz,
          currentQuestionIndex: 0,
          selectedAnswers: {},
        ),
      ],
      verify: (_) {
        verify(() => mockResetQuiz(any())).called(1);
      },
    );
  });
}
