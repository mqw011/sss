import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class MinimalInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onSend;

  const MinimalInputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: AppTextStyles.bodyChat,
              cursorColor: AppColors.accentNeonPurple,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyles.bodyCaption,
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
              ),
              onSubmitted: (_) => onSend(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send_rounded, color: AppColors.accentNeonPurple),
            onPressed: onSend,
            splashRadius: 24,
          ),
        ],
      ),
    );
  }
}
