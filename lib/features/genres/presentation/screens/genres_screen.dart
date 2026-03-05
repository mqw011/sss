import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/glass_app_bar.dart';
import '../../../../core/widgets/polaroid_card.dart';
import '../providers/genres_provider.dart';
import '../../../subgenres/presentation/screens/subgenres_screen.dart';

class GenresScreen extends ConsumerStatefulWidget {
  const GenresScreen({super.key});

  @override
  ConsumerState<GenresScreen> createState() => _GenresScreenState();
}

class _GenresScreenState extends ConsumerState<GenresScreen> {
  // Generate stable random angles for cards so they don't jitter on scroll
  final List<double> _angles = List.generate(20, (index) {
    final random = math.Random(index); // stable seed
    return (random.nextDouble() - 0.5) * 0.15; // Random angle between -0.075 and 0.075 rad
  });

  @override
  Widget build(BuildContext context) {
    final genresAsync = ref.watch(genresProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const GlassAppBar(
        title: 'Vault',
        showBackButton: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -0.6),
            radius: 1.5,
            colors: [
              AppColors.surfaceLight,
              AppColors.background,
            ],
          ),
        ),
        child: genresAsync.when(
          data: (genres) => GridView.builder(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: MediaQuery.of(context).padding.top + kToolbarHeight + 30,
              bottom: 60,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 24,
              mainAxisSpacing: 36,
              childAspectRatio: 0.68, // Taller aspect ratio for polaroid
            ),
            itemCount: genres.length,
            itemBuilder: (context, index) {
              final genre = genres[index];
              return Center(
                child: PolaroidCard(
                  heroTag: 'genre_${genre.id}',
                  imageUrl: genre.imageUrl,
                  title: genre.name,
                  angle: _angles[index % _angles.length],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SubgenresScreen(genre: genre),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.accentNeonPurple),
          ),
          error: (error, _) => Center(
            child: Text('Error: $error', style: AppTextStyles.bodyChat),
          ),
        ),
      ),
    );
  }
}
