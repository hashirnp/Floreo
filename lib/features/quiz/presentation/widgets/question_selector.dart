import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/entities/quiz.dart';

class QuestionSelector extends StatelessWidget {
  final Quiz quiz;
  final int currentIndex;
  final Map<int, int> selectedAnswers;
  final bool isSubmitted;
  final ValueChanged<int> onSelectQuestion;
  final VoidCallback onSubmit;
  final VoidCallback onRestart;

  const QuestionSelector({
    super.key,
    required this.quiz,
    required this.currentIndex,
    required this.selectedAnswers,
    required this.isSubmitted,
    required this.onSelectQuestion,
    required this.onSubmit,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    final total = quiz.questions.length;
    final answeredCount = selectedAnswers.length;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.optionBorder, width: 1),
        boxShadow: AppColors.softCardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${currentIndex + 1}/$total',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Select an option for each question and navigate using Prev/Next or the Question Grid.',
                      ),
                      duration: Duration(seconds: 3),
                    ),
                  );
                },
                child: const Text(
                  'Need Help ?',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // Grid of Question Circle Badges
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: List.generate(total, (index) {
              final questionNum = index + 1;
              final isCurrent = index == currentIndex;
              final isAnswered = selectedAnswers.containsKey(index);

              bool isCorrect = false;
              if (isAnswered) {
                isCorrect =
                    quiz.questions[index].correctAnswerIndex ==
                    selectedAnswers[index];
              }

              return _QuestionBadgeItem(
                number: questionNum,
                isCurrent: isCurrent,
                isAnswered: isAnswered,
                isCorrect: isCorrect,
                onTap: () => onSelectQuestion(index),
              );
            }),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Selector Legend
          Center(child: _buildLegend()),

          const SizedBox(height: AppSpacing.lg),

          // Action Buttons (Submit Quiz & Restart Quiz)
          if (!isSubmitted) ...[
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: onSubmit,
                icon: const Icon(Icons.send_rounded, size: 18),
                label: Text(
                  answeredCount == total
                      ? 'Submit Quiz'
                      : 'Submit Quiz ($answeredCount/$total)',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                ),
              ),
            ),
            if (answeredCount > 0) ...[
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: OutlinedButton.icon(
                  onPressed: onRestart,
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: const Text(
                    'Restart Quiz',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.errorRed,
                    side: const BorderSide(
                      color: AppColors.errorBorder,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                  ),
                ),
              ),
            ],
          ] else
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: onRestart,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text(
                  'Restart Quiz',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryBlue,
                  side: const BorderSide(
                    color: AppColors.primaryBlue,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return const Wrap(
      spacing: 12,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        _LegendItem(
          color: Color(0xFFBFDBFE),
          label: 'Correct',
          textColor: Color(0xFF1E40AF),
        ),
        _LegendItem(
          color: Color(0xFFFCA5A5),
          label: 'Incorrect',
          textColor: Color(0xFF991B1B),
        ),
        _LegendItem(
          color: Color(0xFFCBD5E1),
          label: 'Unanswered',
          textColor: Color(0xFF475569),
        ),
      ],
    );
  }
}

class _QuestionBadgeItem extends StatefulWidget {
  final int number;
  final bool isCurrent;
  final bool isAnswered;
  final bool isCorrect;
  final VoidCallback onTap;

  const _QuestionBadgeItem({
    required this.number,
    required this.isCurrent,
    required this.isAnswered,
    required this.isCorrect,
    required this.onTap,
  });

  @override
  State<_QuestionBadgeItem> createState() => _QuestionBadgeItemState();
}

class _QuestionBadgeItemState extends State<_QuestionBadgeItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color border;
    Color textColor;

    if (widget.isAnswered) {
      if (widget.isCorrect) {
        bg = const Color(0xFFBFDBFE);
        border = const Color(0xFF93C5FD);
        textColor = const Color(0xFF1E40AF);
      } else {
        bg = const Color(0xFFFCA5A5);
        border = const Color(0xFFF87171);
        textColor = const Color(0xFF991B1B);
      }
    } else {
      bg = const Color(0xFFCBD5E1);
      border = Colors.transparent;
      textColor = const Color(0xFF475569);
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _isHovered && !widget.isCurrent
                ? bg.withValues(alpha: 0.85)
                : bg,
            shape: BoxShape.circle,
            border: Border.all(
              color: widget.isCurrent ? AppColors.primaryBlue : border,
              width: widget.isCurrent ? 2.5 : 1.0,
            ),
            boxShadow: widget.isCurrent
                ? [
                    BoxShadow(
                      color: AppColors.primaryBlue.withValues(alpha: 0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            '${widget.number}',
            style: TextStyle(
              color: textColor,
              fontWeight: widget.isCurrent || widget.isAnswered
                  ? FontWeight.bold
                  : FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final Color? textColor;

  const _LegendItem({required this.color, required this.label, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
            color: textColor ?? AppColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
