import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';

class ResultSummaryCard extends StatelessWidget {
  final int totalQuestions;
  final int correctCount;
  final int incorrectCount;
  final double percentage;
  final VoidCallback onRestart;

  const ResultSummaryCard({
    super.key,
    required this.totalQuestions,
    required this.correctCount,
    required this.incorrectCount,
    required this.percentage,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPassed = percentage >= 60.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        border: Border.all(
          color: isPassed ? AppColors.successBorder : AppColors.answeredBorder,
          width: 2,
        ),
        boxShadow: AppColors.containerShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: isPassed ? AppColors.successBg : AppColors.answeredBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPassed ? Icons.emoji_events_rounded : Icons.quiz_rounded,
              color: isPassed ? AppColors.successGreen : AppColors.primaryBlue,
              size: 44,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'Quiz Completed!',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            isPassed
                ? 'Great job! You passed the assessment.'
                : 'Assessment finished. Keep practicing!',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Main Score Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '$correctCount',
                style: const TextStyle(
                  color: AppColors.primaryBlue,
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                ' / $totalQuestions',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: isPassed ? AppColors.successBg : AppColors.answeredBg,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            ),
            child: Text(
              '${percentage.toStringAsFixed(1)}%',
              style: TextStyle(
                color: isPassed
                    ? AppColors.successGreen
                    : AppColors.primaryDarkBlue,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Breakdown stats
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.sidebarBackground,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  'Correct',
                  '$correctCount',
                  AppColors.successGreen,
                ),
                Container(width: 1, height: 36, color: AppColors.optionBorder),
                _buildStatItem(
                  'Incorrect',
                  '$incorrectCount',
                  AppColors.errorRed,
                ),
                Container(width: 1, height: 36, color: AppColors.optionBorder),
                _buildStatItem(
                  'Total',
                  '$totalQuestions',
                  AppColors.textPrimary,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Restart Quiz Button
          ElevatedButton.icon(
            onPressed: onRestart,
            icon: const Icon(Icons.replay_rounded, size: 18),
            label: const Text('Try Again'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(180, 48),
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color valueColor) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
