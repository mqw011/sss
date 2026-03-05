import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/glass_app_bar.dart';
import '../../../../core/widgets/polaroid_card.dart';
import '../../../genres/domain/entities/genre.dart';
import '../../../chat/presentation/screens/chat_screen.dart';

class SubgenresScreen extends StatelessWidget {
  final Genre genre;

  const SubgenresScreen({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: genre.name.replaceAll('\n', ' '),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.surfaceLight,
              AppColors.background,
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.of(context).padding.top + kToolbarHeight + 40),
            ),
            
            // Hero Header 
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 220,
                      height: 300,
                      child: IgnorePointer(
                        child: PolaroidCard(
                          heroTag: 'genre_${genre.id}',
                          imageUrl: genre.imageUrl,
                          title: genre.name,
                          angle: -0.04,
                          onTap: () {},
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Communities',
                        style: AppTextStyles.heading2,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final subgenre = genre.subgenres[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatScreen(subgenre: subgenre),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.background.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Hero(
                            tag: 'subgenre_${subgenre.id}',
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                image: DecorationImage(
                                  image: NetworkImage(subgenre.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(subgenre.name, style: AppTextStyles.heading3.copyWith(fontSize: 18)),
                                const SizedBox(height: 6),
                                Text(
                                  subgenre.description,
                                  style: AppTextStyles.bodyCaption,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.accentNeonPurple.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.blur_on_rounded, color: AppColors.accentNeonPurple, size: 14),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${(subgenre.membersCount / 1000).toStringAsFixed(1)}k',
                                      style: AppTextStyles.bodyCaption.copyWith(
                                        color: AppColors.accentNeonPurple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: genre.subgenres.length,
              ),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 60)),
          ],
        ),
      ),
    );
  }
}
