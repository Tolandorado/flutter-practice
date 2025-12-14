import '../modal/board.dart';

abstract class BoardsRepository {
  Future<void> create(Board board);
  Future<Board?> findById(BoardId id);
  Future<List<Board>> findAll();
}

class InMemoryBoardsRepository implements BoardsRepository {
  final Map<BoardId, Board> _storage = {};

  Map<BoardId, Board> get storage => _storage;

  @override
  Future<void> create(Board board) async {
    _storage[board.id] = board;
  }

  @override
  Future<Board?> findById(BoardId id) async {
    return _storage[id];
  }

  @override
  Future<List<Board>> findAll() async {
    return _storage.values.toList();
  }
}

class MockBoardsRepository implements BoardsRepository {
  final List<Board> createdBoards = [];

  @override
  Future<void> create(Board board) async {
    createdBoards.add(board);
  }

  @override
  Future<Board?> findById(BoardId id) async {
    final matches = createdBoards.where((b) => b.id == id);
    return matches.isNotEmpty ? matches.first : null;
  }

  @override
  Future<List<Board>> findAll() async {
    return List.unmodifiable(createdBoards);
  }
}
