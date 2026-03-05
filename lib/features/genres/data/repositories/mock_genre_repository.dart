import '../../domain/entities/genre.dart';
import '../../domain/entities/subgenre.dart';

abstract class IGenreRepository {
  Future<List<Genre>> getGenres();
}

class MockGenreRepository implements IGenreRepository {
  @override
  Future<List<Genre>> getGenres() async {
    await Future.delayed(const Duration(milliseconds: 400));

    return const [
      Genre(
        id: "genre_hiphop",
        name: "Hip-hop \nCulture",
        imageUrl: "https://images.unsplash.com/photo-1547822297-bea7b63fdd2a?q=80&w=800&auto=format&fit=crop",
        subgenres: [
          Subgenre(
            id: "sub_emo_rap",
            name: "Emo Rap & Sad Trap",
            imageUrl: "https://images.unsplash.com/photo-1518609878373-06d740f60d8b?q=80&w=800&auto=format&fit=crop",
            membersCount: 18940,
            description: "Эстетика разбитых сердец, перегруженных 808-х басов и мрачных гитарных семплов. Наследие Lil Peep и Juice WRLD живет здесь.",
          ),
          Subgenre(
            id: "sub_rage",
            name: "Rage / Opium",
            imageUrl: "https://images.unsplash.com/photo-1557672810-6bc3fe7dc9eb?q=80&w=800&auto=format&fit=crop",
            membersCount: 45210,
            description: "Синтезаторы из видеоигр, агрессивная энергия и чистый хаос мошпитов. Вибрации Playboi Carti и Ken Carson.",
          ),
          Subgenre(
            id: "sub_classic",
            name: "Classic / Boom Bap",
            imageUrl: "https://images.unsplash.com/photo-1516280440502-8692debe3dc5?q=80&w=800&auto=format&fit=crop",
            membersCount: 84200,
            description: "Золотая эра 90-х. Загрязненные драм-лупы, виниловый треск и поэзия улиц Нью-Йорка.",
          ),
        ],
      ),
      Genre(
        id: "genre_kpop",
        name: "K-Pop",
        imageUrl: "https://images.unsplash.com/photo-1543807535-eceef0bc6599?q=80&w=800&auto=format&fit=crop",
        subgenres: [
          Subgenre(
            id: "sub_4th_gen",
            name: "4th Gen & Y2K",
            imageUrl: "https://images.unsplash.com/photo-1614680376573-df3480f0c6ff?q=80&w=800&auto=format&fit=crop",
            membersCount: 134500,
            description: "Пик визуальной эстетики. Дерзкие эксперименты с EDM, киберпанком и ностальгией нулевых (от Stray Kids до NewJeans).",
          ),
        ],
      ),
      Genre(
        id: "genre_pop",
        name: "Pop & Synth",
        imageUrl: "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=800&auto=format&fit=crop",
        subgenres: [
          Subgenre(
            id: "sub_synthpop",
            name: "Midnight Synth",
            imageUrl: "https://images.unsplash.com/photo-1614613535308-eb5fbd3d2c17?q=80&w=800&auto=format&fit=crop",
            membersCount: 42000,
            description: "Бесконечная ночь, неоновые вывески и ностальгия по 80-м. Мрачный и притягательный звук The Weeknd и Kavinsky.",
          ),
          Subgenre(
            id: "sub_indie",
            name: "Bedroom Indie",
            imageUrl: "https://images.unsplash.com/photo-1496293455970-f8581aae0e4b?q=80&w=800&auto=format&fit=crop",
            membersCount: 22100,
            description: "Искренняя, lo-fi поп-музыка, записанная в спальне. Теплые синтезаторы и шепчущий вокал.",
          ),
        ],
      ),
    ];
  }
}
