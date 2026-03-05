import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/subgenre.dart';
import '../../data/repositories/mock_subgenre_repository.dart';
import '../../domain/repositories/subgenre_repository.dart';

final subgenreRepositoryProvider = Provider<SubgenreRepository>((ref) {
  return MockSubgenreRepository();
});

final subgenresProvider = FutureProvider.family<List<Subgenre>, String>((ref, genreId) async {
  final repository = ref.watch(subgenreRepositoryProvider);
  return repository.getSubgenres(genreId);
});
