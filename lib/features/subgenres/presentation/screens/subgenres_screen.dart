import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/glass_app_bar.dart';
import '../../../../core/widgets/polaroid_card.dart';
import '../../../genres/domain/entities/genre.dart';
import '../../../chat/presentation/screens/chat_screen.dart';
import '../providers/subgenres_provider.dart';

class SubgenresScreen extends ConsumerWidget {
  final Genre genre;

  const SubgenresScreen({super.key, required this.genre});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subgenresAsync = ref.watch(subgenresProvider(genre.id));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: 'ARCHIVE_DETAIL_VIEW',
        showBackButton: true,
      ),
      body: Container(
        color: AppColors.backgroundDark,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.of(context).padding.top + kToolbarHeight + 24),
            ),
            // Selected Polaroid
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: PolaroidCard(
                  heroTag: 'genre_${genre.id}',
                  imageUrl: genre.imageUrl,
                  title: genre.name,
                  compact: false, onTap: () {},
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            
            // Sensor Data Panel
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.03),
                    border: Border.all(color: AppColors.neonCyan.withValues(alpha: 0.3)),
                    borderRadius: BorderRadius.circular(2), // Sharp corners
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('SENSOR DATA', style: AppTextStyles.metaStyle.copyWith(color: AppColors.neonCyan)),
                          const Icon(Icons.wifi_tethering, color: AppColors.neonCyan, size: 16),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _SensorRow(label: 'COORDINATES:', value: '35.6895° N, 139.6917° E'),
                      _SensorRow(label: 'ENERGY LEVEL:', value: 'HIGH_VARIANCE'),
                      _SensorRow(label: 'ENCRYPTION:', value: 'AES-256 (ACTIVE)'),
                    ],
                  ),
                ),
              ),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            
            // Channels Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Row(
                  children: [
                    const Icon(Icons.lock_outline, color: AppColors.primary, size: 16),
                    const SizedBox(width: 8),
                    Text('ENCRYPTED CHANNELS', style: AppTextStyles.bodyStyle.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    )),
                  ],
                ),
              ),
            ),
            
            // Subgenres List
            subgenresAsync.when(
              data: (subgenres) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final subgenre = subgenres[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatScreen(subgenre: subgenre),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                            gradient: LinearPaddingGradient(),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '// ${subgenre.name.toUpperCase()}',
                                    style: AppTextStyles.bodyStyle.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    subgenre.description,
                                    style: AppTextStyles.metaStyle.copyWith(color: AppColors.textSecondary),
                                  ),
                                ],
                              ),
                              const Icon(Icons.arrow_forward_ios, color: AppColors.primary, size: 16),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: subgenres.length,
                ),
              ),
              loading: () => const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
              error: (err, _) => SliverToBoxAdapter(child: Text('Error: $err', style: TextStyle(color: Colors.white))),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }

  LinearGradient LinearPaddingGradient() {
    return LinearGradient(
      colors: [Colors.white.withValues(alpha: 0.05), Colors.transparent],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }
}

class _SensorRow extends StatelessWidget {
  final String label;
  final String value;

  const _SensorRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.metaStyle),
          Text(value, style: AppTextStyles.codeStyle),
        ],
      ),
    );
  }
}
