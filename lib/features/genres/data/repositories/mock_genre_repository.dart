import '../../domain/entities/genre.dart';
import '../../domain/repositories/genre_repository.dart';

class MockGenreRepository implements GenreRepository {
  @override
  Future<List<Genre>> getGenres() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    return [
      Genre(
        id: '1',
        name: 'Archive_01\nTokyo Nights',
        imageUrl: 'https://images.unsplash.com/photo-1542281286-9e0a16bb7366?auto=format&fit=crop&q=80&w=800',
        description: 'Sector 04 - Captured 1989',
      ),
      Genre(
        id: '2',
        name: 'Archive_02\nNeon Alley',
        imageUrl: 'https://images.unsplash.com/photo-1555448248-2571daf6344b?auto=format&fit=crop&q=80&w=800',
        description: 'Sector 07 - Captured 1992',
      ),
      Genre(
        id: '3',
        name: 'Archive_03\nMidnight Static',
        imageUrl: 'https://images.unsplash.com/photo-1605806616949-1e87b487cb2a?auto=format&fit=crop&q=80&w=800',
        description: 'Sector 02 - Captured 1995',
      ),
      Genre(
        id: '4',
        name: 'Archive_04\nGlitch Protocol',
        imageUrl: 'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?auto=format&fit=crop&q=80&w=800',
        description: 'Unknown Sector - Date Corrupted',
      ),
    ];
  }
}
