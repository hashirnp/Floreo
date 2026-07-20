import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';

class QuizNavigation extends StatelessWidget {
  final int currentIndex;
  final int totalQuestions;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const QuizNavigation({
    super.key,
    required this.currentIndex,
    required this.totalQuestions,
    required this.onPrevious,
    required this.onNext,
  });

  bool get isFirst => currentIndex == 0;
  bool get isLast => currentIndex == totalQuestions - 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Prev Button
          SizedBox(
            width: 120,
            height: 44,
            child: OutlinedButton.icon(
              onPressed: isFirst ? null : onPrevious,
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 14),
              label: const Text('Prev'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                disabledForegroundColor: AppColors.textMuted,
                side: BorderSide(
                  color: isFirst
                      ? AppColors.unansweredBg
                      : AppColors.optionBorder,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                ),
                elevation: isFirst ? 0 : 2,
                shadowColor: Colors.black.withValues(alpha: 0.05),
                backgroundColor: AppColors.cardSurface,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),

          // Next Button
          SizedBox(
            width: 120,
            height: 44,
            child: OutlinedButton(
              onPressed: isLast ? null : onNext,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                disabledForegroundColor: AppColors.textMuted,
                side: BorderSide(
                  color: isLast
                      ? AppColors.unansweredBg
                      : AppColors.optionBorder,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                ),
                elevation: isLast ? 0 : 2,
                shadowColor: Colors.black.withValues(alpha: 0.05),
                backgroundColor: AppColors.cardSurface,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Next'),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward_ios_rounded, size: 14),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
