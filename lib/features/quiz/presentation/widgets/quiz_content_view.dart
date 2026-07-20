import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_spacing.dart';
import '../bloc/quiz_bloc.dart';
import '../bloc/quiz_event.dart';
import '../bloc/quiz_state.dart';
import 'answer_options_list.dart';
import 'explanation_card.dart';
import 'question_card.dart';
import 'question_selector.dart';
import 'quiz_header.dart';
import 'quiz_navigation.dart';
import 'restart_dialog.dart';
import 'score_summary_bar.dart';

class QuizContentView extends StatelessWidget {
  final QuizState state;

  const QuizContentView({super.key, required this.state});

  void _handleRestart(BuildContext context) {
    if (state.isSubmitted) {
      context.read<QuizBloc>().add(const RestartQuiz());
    } else {
      RestartConfirmationDialog.show(
        context,
        onConfirm: () => context.read<QuizBloc>().add(const RestartQuiz()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final quiz = state.quiz!;
    final currentQuestion = state.currentQuestion!;
    final isCurrentQuestionAnswered = state.selectedAnswers.containsKey(
      state.currentQuestionIndex,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isDesktop = width >= AppSpacing.tabletMax;
        final isTablet =
            width >= AppSpacing.mobileMax && width < AppSpacing.tabletMax;

        if (isDesktop || isTablet) {
          final double padding = isDesktop ? AppSpacing.xl : AppSpacing.md;
          final int leftFlex = isDesktop ? 7 : 6;
          final int rightFlex = 4;

          return Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              children: [
                QuizHeader(title: quiz.title, isSubmitted: state.isSubmitted),
                const SizedBox(height: AppSpacing.lg),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column: Question, Options, Prev/Next & Explanation
                      Expanded(
                        flex: leftFlex,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(right: AppSpacing.md),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (state.isSubmitted) ...[
                                ScoreSummaryBar(
                                  state: state,
                                  onRestart: () => _handleRestart(context),
                                ),
                                const SizedBox(height: AppSpacing.lg),
                              ],
                              QuestionCard(
                                question: currentQuestion,
                                questionNumber: state.currentQuestionIndex + 1,
                              ),
                              const SizedBox(height: AppSpacing.lg),
                              AnswerOptionsList(
                                question: currentQuestion,
                                questionIndex: state.currentQuestionIndex,
                                state: state,
                              ),
                              QuizNavigation(
                                currentIndex: state.currentQuestionIndex,
                                totalQuestions: state.totalQuestions,
                                onPrevious: () => context.read<QuizBloc>().add(
                                  const GoToPreviousQuestion(),
                                ),
                                onNext: () => context.read<QuizBloc>().add(
                                  const GoToNextQuestion(),
                                ),
                              ),
                              ExplanationCard(
                                explanation: currentQuestion.explanation,
                                isAnswered: isCurrentQuestionAnswered,
                                isSubmitted: state.isSubmitted,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Right Column: Question Selector Grid Panel
                      Expanded(
                        flex: rightFlex,
                        child: SingleChildScrollView(
                          child: QuestionSelector(
                            quiz: quiz,
                            currentIndex: state.currentQuestionIndex,
                            selectedAnswers: state.selectedAnswers,
                            isSubmitted: state.isSubmitted,
                            onSelectQuestion: (index) => context
                                .read<QuizBloc>()
                                .add(NavigateToQuestion(index)),
                            onSubmit: () => context.read<QuizBloc>().add(
                              const SubmitQuiz(),
                            ),
                            onRestart: () => _handleRestart(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          // Mobile Layout (< 600px width)
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QuizHeader(title: quiz.title, isSubmitted: state.isSubmitted),
                const SizedBox(height: AppSpacing.md),
                if (state.isSubmitted) ...[
                  ScoreSummaryBar(
                    state: state,
                    onRestart: () => _handleRestart(context),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                QuestionCard(
                  question: currentQuestion,
                  questionNumber: state.currentQuestionIndex + 1,
                ),
                const SizedBox(height: AppSpacing.md),
                AnswerOptionsList(
                  question: currentQuestion,
                  questionIndex: state.currentQuestionIndex,
                  state: state,
                ),
                QuizNavigation(
                  currentIndex: state.currentQuestionIndex,
                  totalQuestions: state.totalQuestions,
                  onPrevious: () => context.read<QuizBloc>().add(
                    const GoToPreviousQuestion(),
                  ),
                  onNext: () =>
                      context.read<QuizBloc>().add(const GoToNextQuestion()),
                ),
                ExplanationCard(
                  explanation: currentQuestion.explanation,
                  isAnswered: isCurrentQuestionAnswered,
                  isSubmitted: state.isSubmitted,
                ),
                const SizedBox(height: AppSpacing.lg),
                QuestionSelector(
                  quiz: quiz,
                  currentIndex: state.currentQuestionIndex,
                  selectedAnswers: state.selectedAnswers,
                  isSubmitted: state.isSubmitted,
                  onSelectQuestion: (index) =>
                      context.read<QuizBloc>().add(NavigateToQuestion(index)),
                  onSubmit: () =>
                      context.read<QuizBloc>().add(const SubmitQuiz()),
                  onRestart: () => _handleRestart(context),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
