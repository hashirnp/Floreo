import 'package:get_it/get_it.dart';
import 'features/quiz/data/datasources/quiz_local_datasource.dart';
import 'features/quiz/data/datasources/quiz_remote_datasource.dart';
import 'features/quiz/data/repositories/quiz_repository_impl.dart';
import 'features/quiz/domain/repositories/quiz_repository.dart';
import 'features/quiz/domain/usecases/get_quiz.dart';
import 'features/quiz/domain/usecases/get_quiz_progress.dart';
import 'features/quiz/domain/usecases/reset_quiz.dart';
import 'features/quiz/domain/usecases/save_quiz_progress.dart';
import 'features/quiz/presentation/bloc/quiz_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory<QuizBloc>(
    () => QuizBloc(
      getQuiz: sl(),
      getQuizProgress: sl(),
      saveQuizProgress: sl(),
      resetQuiz: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetQuiz(sl()));
  sl.registerLazySingleton(() => GetQuizProgress(sl()));
  sl.registerLazySingleton(() => SaveQuizProgress(sl()));
  sl.registerLazySingleton(() => ResetQuiz(sl()));

  // Repository
  sl.registerLazySingleton<QuizRepository>(
    () => QuizRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<QuizRemoteDataSource>(
    () => QuizRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<QuizLocalDataSource>(
    () => QuizLocalDataSourceImpl(),
  );
}
