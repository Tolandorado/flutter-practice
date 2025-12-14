import '../modal/message.dart';
import '../modal/board.dart';

abstract class MessagesRepository {
  Future<void> create(Message message);
  Future<List<Message>> findByBoard(BoardId boardId);
}

class InMemoryMessagesRepository implements MessagesRepository {
  final Map<BoardId, List<Message>> _storage = {};

  Map<BoardId, List<Message>> get storage => _storage;

  @override
  Future<void> create(Message message) async {
    _storage.putIfAbsent(message.boardId, () => []);
    _storage[message.boardId]!.add(message);
  }

  @override
  Future<List<Message>> findByBoard(BoardId boardId) async {
    return _storage[boardId] ?? [];
  }
}

class MockMessagesRepository implements MessagesRepository {
  final List<Message> createdMessages = [];

  @override
  Future<void> create(Message message) async {
    createdMessages.add(message);
  }

  @override
  Future<List<Message>> findByBoard(BoardId boardId) async {
    return createdMessages.where((m) => m.boardId == boardId).toList();
  }
}
