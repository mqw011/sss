import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/genre.dart';
import '../../data/repositories/mock_genre_repository.dart';
import '../../domain/repositories/genre_repository.dart';

final genreRepositoryProvider = Provider<GenreRepository>((ref) {
  return MockGenreRepository();
});

final genresProvider = FutureProvider<List<Genre>>((ref) async {
  final repository = ref.watch(genreRepositoryProvider);
  return repository.getGenres();
});
