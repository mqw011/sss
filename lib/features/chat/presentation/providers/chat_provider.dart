import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/message.dart';
import '../../data/repositories/mock_chat_repository.dart';

final chatRepositoryProvider = Provider<MockChatRepository>((ref) {
  return MockChatRepository();
});

final chatProvider = FutureProvider.autoDispose.family<List<Message>, String>((ref, id) {
  return ref.watch(chatRepositoryProvider).getChatHistory(id);
});
