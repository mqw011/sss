import '../../domain/entities/message.dart';

abstract class IChatRepository {
  Future<List<Message>> getChatHistory(String subgenreId);
  Future<void> sendMessage(String subgenreId, String text);
}

class MockChatRepository implements IChatRepository {
  final Map<String, List<Message>> _mockDb = {
    "sub_emo_rap": [
      Message(
        id: "msg_1",
        senderId: "user_21",
        senderName: "SadBoy99",
        text: "Кто-нибудь слушал новый дроп? Звучит как старый Peep, прям возвращает в 2017.",
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      Message(
        id: "msg_2",
        senderId: "user_42",
        senderName: "VinylJunkie",
        text: "Да, бас просто сумасшедший. А этот гитарный семпл на фоне? Мрак.",
        timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
      ),
      Message(
        id: "msg_3",
        senderId: "user_my",
        senderName: "Me",
        text: "Согласен, продюсер отлично поработал с атмосферой.",
        timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
        isMine: true,
      ),
    ]
  };

  @override
  Future<List<Message>> getChatHistory(String subgenreId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockDb[subgenreId] ?? [];
  }

  @override
  Future<void> sendMessage(String subgenreId, String text) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final messages = _mockDb[subgenreId] ?? [];
    messages.add(
      Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderId: "user_my",
        senderName: "Me",
        text: text,
        timestamp: DateTime.now(),
        isMine: true,
      ),
    );
    _mockDb[subgenreId] = messages;
  }
}
