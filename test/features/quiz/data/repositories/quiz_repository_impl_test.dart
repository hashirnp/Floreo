import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:floreo/features/quiz/data/datasources/quiz_local_datasource.dart';
import 'package:floreo/features/quiz/data/datasources/quiz_remote_datasource.dart';
import 'package:floreo/features/quiz/data/models/quiz_model.dart';
import 'package:floreo/features/quiz/data/models/quiz_progress_model.dart';

import 'package:floreo/features/quiz/data/repositories/quiz_repository_impl.dart';
import 'package:floreo/features/quiz/domain/entities/quiz_progress.dart';

class MockQuizRemoteDataSource extends Mock implements QuizRemoteDataSource {}

class MockQuizLocalDataSource extends Mock implements QuizLocalDataSource {}

void main() {
  late QuizRepositoryImpl repository;
  late MockQuizRemoteDataSource mockRemoteDataSource;
  late MockQuizLocalDataSource mockLocalDataSource;

  const tQuizModel = QuizModel(
    id: 'repo_quiz',
    title: 'Repo Quiz',
    questions: [],
  );

  const tQuizProgressModel = QuizProgressModel(
    currentQuestionIndex: 2,
    selectedAnswers: {0: 1, 1: 3},
    isSubmitted: false,
  );

  setUpAll(() {
    registerFallbackValue(tQuizModel);
    registerFallbackValue(tQuizProgressModel);
  });

  setUp(() {
    mockRemoteDataSource = MockQuizRemoteDataSource();
    mockLocalDataSource = MockQuizLocalDataSource();
    repository = QuizRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('getQuiz', () {
    test(
      'should fetch quiz from remote datasource and cache it locally when remote call succeeds',
      () async {
        when(
          () => mockRemoteDataSource.fetchQuiz(),
        ).thenAnswer((_) async => tQuizModel);
        when(
          () => mockLocalDataSource.cacheQuiz(any()),
        ).thenAnswer((_) async {});

        final result = await repository.getQuiz();

        expect(result, equals(tQuizModel));
        verify(() => mockRemoteDataSource.fetchQuiz()).called(1);
        verify(() => mockLocalDataSource.cacheQuiz(tQuizModel)).called(1);
      },
    );

    test(
      'should return cached quiz when remote datasource call throws error',
      () async {
        when(
          () => mockRemoteDataSource.fetchQuiz(),
        ).thenThrow(Exception('Network error'));
        when(
          () => mockLocalDataSource.getCachedQuiz(),
        ).thenAnswer((_) async => tQuizModel);

        final result = await repository.getQuiz();

        expect(result, equals(tQuizModel));
        verify(() => mockRemoteDataSource.fetchQuiz()).called(1);
        verify(() => mockLocalDataSource.getCachedQuiz()).called(1);
      },
    );
  });

  group('getQuizProgress and saveQuizProgress', () {
    test('should return progress from local data source', () async {
      when(
        () => mockLocalDataSource.getQuizProgress(),
      ).thenAnswer((_) async => tQuizProgressModel);

      final result = await repository.getQuizProgress();

      expect(result, equals(tQuizProgressModel));
      verify(() => mockLocalDataSource.getQuizProgress()).called(1);
    });

    test('should delegate saveQuizProgress to local data source', () async {
      when(
        () => mockLocalDataSource.saveQuizProgress(any()),
      ).thenAnswer((_) async {});

      const progress = QuizProgress(
        currentQuestionIndex: 1,
        selectedAnswers: {0: 2},
        isSubmitted: false,
      );

      await repository.saveQuizProgress(progress);

      verify(() => mockLocalDataSource.saveQuizProgress(any())).called(1);
    });
  });
}
