import '../entities/subgenre.dart';

abstract class SubgenreRepository {
  Future<List<Subgenre>> getSubgenres(String genreId);
}
