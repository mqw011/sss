import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/genre.dart';
import '../../data/repositories/mock_genre_repository.dart';

// Provider for Repository Layer
final genreRepositoryProvider = Provider<IGenreRepository>((ref) {
  return MockGenreRepository();
});

// Provider for State
final genresProvider = FutureProvider<List<Genre>>((ref) async {
  final repository = ref.watch(genreRepositoryProvider);
  return repository.getGenres();
});
