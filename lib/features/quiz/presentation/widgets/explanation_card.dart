import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';

class ExplanationCard extends StatelessWidget {
  final String explanation;
  final bool isAnswered;
  final bool isSubmitted;

  const ExplanationCard({
    super.key,
    required this.explanation,
    required this.isAnswered,
    required this.isSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final showExplanation = isAnswered || isSubmitted;

    if (!showExplanation) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.sidebarBackground,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(color: AppColors.optionBorder, width: 1),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.info_outline_rounded,
              color: AppColors.textSecondary,
              size: 20,
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                'Explanation will be available after selecting an answer.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.answeredBorder, width: 1.5),
        boxShadow: AppColors.softCardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.lightbulb_rounded,
                color: AppColors.primaryBlue,
                size: 22,
              ),
              SizedBox(width: AppSpacing.sm),
              Text(
                'Explanation',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            explanation,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              height: 1.6,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
