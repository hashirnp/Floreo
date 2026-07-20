import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../bloc/quiz_state.dart';
import 'result_summary.dart';

class ScoreSummaryBar extends StatelessWidget {
  final QuizState state;
  final VoidCallback onRestart;

  const ScoreSummaryBar({
    super.key,
    required this.state,
    required this.onRestart,
  });

  void _showResultSummaryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: ResultSummaryCard(
            totalQuestions: state.totalQuestions,
            correctCount: state.correctCount,
            incorrectCount: state.incorrectCount,
            percentage: state.percentage,
            onRestart: () {
              Navigator.of(dialogContext).pop();
              onRestart();
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.successBg,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.successBorder, width: 1.5),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 480;

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.emoji_events_rounded,
                      color: AppColors.successGreen,
                      size: 26,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Quiz Submitted - Review Mode',
                            style: TextStyle(
                              color: AppColors.successGreen,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Score: ${state.score}/${state.totalQuestions} (${state.percentage.toStringAsFixed(0)}%) • Correct: ${state.correctCount} • Incorrect: ${state.incorrectCount}',
                            style: TextStyle(
                              color: AppColors.textPrimary.withValues(
                                alpha: 0.8,
                              ),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _showResultSummaryDialog(context),
                    icon: const Icon(Icons.bar_chart_rounded, size: 16),
                    label: const Text('View Summary'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.successGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ],
            );
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(
                      Icons.emoji_events_rounded,
                      color: AppColors.successGreen,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Quiz Submitted - Review Mode',
                            style: TextStyle(
                              color: AppColors.successGreen,
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Score: ${state.score} / ${state.totalQuestions} (${state.percentage.toStringAsFixed(0)}%) | Correct: ${state.correctCount} | Incorrect: ${state.incorrectCount}',
                            style: TextStyle(
                              color: AppColors.textPrimary.withValues(
                                alpha: 0.8,
                              ),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => _showResultSummaryDialog(context),
                icon: const Icon(Icons.bar_chart_rounded, size: 16),
                label: const Text('View Summary'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.successGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
