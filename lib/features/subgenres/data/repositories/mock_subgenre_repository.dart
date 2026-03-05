import '../../domain/entities/subgenre.dart';
import '../../domain/repositories/subgenre_repository.dart';

class MockSubgenreRepository implements SubgenreRepository {
  @override
  Future<List<Subgenre>> getSubgenres(String genreId) async {
    await Future.delayed(const Duration(milliseconds: 600));

    return [
      Subgenre(
        id: 'sub_1',
        genreId: genreId,
        name: 'CHANNEL_0X1',
        description: 'ENCRYPTED_STREAM_ALPHA',
        imageUrl: 'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?auto=format&fit=crop&q=80&w=800',
      ),
      Subgenre(
        id: 'sub_2',
        genreId: genreId,
        name: 'CHANNEL_0X2',
        description: 'DECRYPTING_SIGNAL...',
        imageUrl: 'https://images.unsplash.com/photo-1605806616949-1e87b487cb2a?auto=format&fit=crop&q=80&w=800',
      ),
      Subgenre(
        id: 'sub_3',
        genreId: genreId,
        name: 'CHANNEL_0X3',
        description: 'CORRUPTED_DATA_BLOCK',
        imageUrl: 'https://images.unsplash.com/photo-1555448248-2571daf6344b?auto=format&fit=crop&q=80&w=800',
      ),
    ];
  }
}
