import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';

class AnswerOption extends StatefulWidget {
  final String optionText;
  final int optionIndex;
  final bool isSelected;
  final bool isAnswered; // Whether this question has an answer selected
  final bool isCorrectAnswer;
  final VoidCallback? onTap;

  const AnswerOption({
    super.key,
    required this.optionText,
    required this.optionIndex,
    required this.isSelected,
    required this.isAnswered,
    required this.isCorrectAnswer,
    this.onTap,
  });

  @override
  State<AnswerOption> createState() => _AnswerOptionState();
}

class _AnswerOptionState extends State<AnswerOption> {
  bool _isHovered = false;

  String get _optionLetter {
    return String.fromCharCode(65 + widget.optionIndex); // 0 -> A, 1 -> B, etc.
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = AppColors.cardSurface;
    Color borderColor = AppColors.optionBorder;
    Color textColor = AppColors.textPrimary;
    Widget leadingWidget;
    Widget? badgeWidget;

    if (widget.isAnswered) {
      // Question has been answered -> Show immediate correctness feedback & locking
      if (widget.isSelected && widget.isCorrectAnswer) {
        // User selected the correct answer
        backgroundColor = AppColors.successBg;
        borderColor = AppColors.successGreen;
        textColor = AppColors.successGreen;
        leadingWidget = _buildCircleIcon(
          icon: Icons.check_rounded,
          color: AppColors.successGreen,
          bgColor: Colors.white,
        );
        badgeWidget = _buildBadge(
          'Correct',
          AppColors.successGreen,
          AppColors.successBg,
        );
      } else if (widget.isSelected && !widget.isCorrectAnswer) {
        // User selected the wrong answer
        backgroundColor = AppColors.errorBg;
        borderColor = AppColors.errorRed;
        textColor = AppColors.errorRed;
        leadingWidget = _buildCircleIcon(
          icon: Icons.close_rounded,
          color: AppColors.errorRed,
          bgColor: Colors.white,
        );
        badgeWidget = _buildBadge(
          'Your Choice (Incorrect)',
          AppColors.errorRed,
          AppColors.errorBg,
        );
      } else if (!widget.isSelected && widget.isCorrectAnswer) {
        // Correct answer that user didn't pick
        backgroundColor = AppColors.successBg.withValues(alpha: 0.5);
        borderColor = AppColors.successGreen;
        textColor = const Color(0xFF047857);
        leadingWidget = _buildCircleIcon(
          icon: Icons.check_rounded,
          color: AppColors.successGreen,
          bgColor: Colors.white,
        );
        badgeWidget = _buildBadge(
          'Correct Answer',
          AppColors.successGreen,
          AppColors.successBg,
        );
      } else {
        // Other unselected options for this answered question
        backgroundColor = AppColors.cardSurface;
        borderColor = AppColors.optionBorder.withValues(alpha: 0.5);
        textColor = AppColors.textMuted;
        leadingWidget = _buildLetterCircle(
          _optionLetter,
          AppColors.textMuted,
          AppColors.unansweredBg,
        );
      }
    } else {
      // Unanswered question -> Selectable neutral options
      backgroundColor = _isHovered
          ? AppColors.optionHover
          : AppColors.cardSurface;
      borderColor = _isHovered
          ? AppColors.primaryLightBlue
          : AppColors.optionBorder;
      textColor = AppColors.textPrimary;
      leadingWidget = _buildLetterCircle(
        _optionLetter,
        _isHovered ? AppColors.primaryBlue : AppColors.textSecondary,
        _isHovered ? AppColors.answeredBg : AppColors.unansweredBg,
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.isAnswered
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.isAnswered ? null : widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: AppSpacing.sm + 2),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md - 2,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(
              color: borderColor,
              width:
                  (widget.isAnswered &&
                      (widget.isSelected || widget.isCorrectAnswer))
                  ? 2
                  : 1.5,
            ),
            boxShadow: _isHovered && !widget.isAnswered
                ? [
                    BoxShadow(
                      color: AppColors.primaryBlue.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              leadingWidget,
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  widget.optionText,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                    fontWeight:
                        widget.isSelected ||
                            (widget.isAnswered && widget.isCorrectAnswer)
                        ? FontWeight.w700
                        : FontWeight.w500,
                  ),
                ),
              ),
              if (badgeWidget != null) ...[
                const SizedBox(width: AppSpacing.sm),
                badgeWidget,
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircleIcon({
    required IconData icon,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
      child: Icon(icon, color: color, size: 18),
    );
  }

  Widget _buildLetterCircle(String letter, Color textColor, Color bgColor) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color color, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
