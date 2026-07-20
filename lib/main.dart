import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/theme/app_theme.dart';
import 'features/quiz/presentation/bloc/quiz_bloc.dart';
import 'features/quiz/presentation/pages/quiz_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Hive.initFlutter();
  } catch (e) {
    debugPrint('Hive init warning: $e');
  }

  try {
    await di.init();
  } catch (e) {
    debugPrint('DI init warning: $e');
  }

  runApp(const FloreoQuizApp());
}

class FloreoQuizApp extends StatelessWidget {
  const FloreoQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Floreo - Technical Assessment Quiz',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: BlocProvider<QuizBloc>(
        create: (_) => di.sl<QuizBloc>(),
        child: const QuizPage(),
      ),
    );
  }
}
