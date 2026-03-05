import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class PolaroidCard extends StatelessWidget {
  final String heroTag;
  final String imageUrl;
  final String title;
  final VoidCallback onTap;
  final double angle;

  const PolaroidCard({
    super.key,
    required this.heroTag,
    required this.imageUrl,
    required this.title,
    required this.onTap,
    this.angle = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.polaroidWhite,
            borderRadius: BorderRadius.circular(2), // Very slight physical rounding
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.8),
                blurRadius: 24,
                spreadRadius: -2,
                offset: const Offset(0, 12),
              ),
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.1),
                blurRadius: 1,
                spreadRadius: 1,
                offset: const Offset(0, 0), // Slight top highlight
              ),
            ],
          ),
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: 32, // More pronounced bottom
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Hero(
                  tag: heroTag,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface, // Placeholder if no image
                      border: Border.all(color: Colors.black12, width: 0.5), // Inner photo border
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                title,
                style: AppTextStyles.polaroidMarker,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
