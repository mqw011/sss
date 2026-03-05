import 'subgenre.dart';

class Genre {
  final String id;
  final String name;
  final String imageUrl;
  final List<Subgenre> subgenres;

  const Genre({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.subgenres,
  });
}
