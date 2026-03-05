import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class PolaroidCard extends StatelessWidget {
  final String heroTag;
  final String imageUrl;
  final String title;
  final VoidCallback onTap;
  final double angle;
  final bool compact; // For grid layout vs detail view

  const PolaroidCard({
    super.key,
    required this.heroTag,
    required this.imageUrl,
    required this.title,
    required this.onTap,
    this.angle = 0.0,
    this.compact = true,
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
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: compact ? 20 : 30,
                offset: Offset(0, compact ? 4 : 10),
              ),
            ],
          ),
          padding: EdgeInsets.only(
            left: compact ? 12 : 16,
            right: compact ? 12 : 16,
            top: compact ? 12 : 16,
            bottom: compact ? 32 : 48,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 1, // aspect-square
                child: Hero(
                  tag: heroTag,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0), // slate-200
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Adds a slight grain overlay effect using ColorFilter in decoration or just let it be
                  ),
                ),
              ),
              SizedBox(height: compact ? 8 : 24),
              Text(
                compact ? title : "Subj: ${title.toUpperCase().replaceAll('\n', ' ')}",
                style: compact ? AppTextStyles.polaroidMarker : AppTextStyles.polaroidCaveat,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (!compact) ...[
                const SizedBox(height: 4),
                Text(
                  "Sector 04 - Captured 1989/09/09",
                  style: AppTextStyles.polaroidCaveat.copyWith(fontSize: 14, color: Colors.blueGrey),
                  textAlign: TextAlign.center,
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
