import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/quiz_question.dart';
import '../bloc/quiz_bloc.dart';
import '../bloc/quiz_event.dart';
import '../bloc/quiz_state.dart';
import 'answer_option.dart';

class AnswerOptionsList extends StatelessWidget {
  final QuizQuestion question;
  final int questionIndex;
  final QuizState state;

  const AnswerOptionsList({
    super.key,
    required this.question,
    required this.questionIndex,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final selectedOption = state.selectedAnswers[questionIndex];
    final isAnswered = selectedOption != null;

    return Column(
      children: List.generate(question.options.length, (index) {
        final optionText = question.options[index];
        final isSelected = selectedOption == index;
        final isCorrect = question.correctAnswerIndex == index;

        return AnswerOption(
          optionText: optionText,
          optionIndex: index,
          isSelected: isSelected,
          isAnswered: isAnswered,
          isCorrectAnswer: isCorrect,
          onTap: () {
            context.read<QuizBloc>().add(
              SelectAnswer(questionIndex: questionIndex, optionIndex: index),
            );
          },
        );
      }),
    );
  }
}
