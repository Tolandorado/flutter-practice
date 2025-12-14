import 'modal/board.dart';
import 'modal/message.dart';
import 'repositories/board_repository.dart';
import 'repositories/message_repository.dart';
import 'modal/content.dart';
import 'modal/author_name.dart';

void main() async {
  final boardsRepo = InMemoryBoardsRepository();
  final messagesRepo = InMemoryMessagesRepository();
  final board = Board(id: BoardId('b1'), title: 'General');

  await boardsRepo.create(board);

  final message = Message(
    id: MessageId('m1'),
    boardId: board.id,
    content: Content('Hello world'),
    authorName: AuthorName('Anon'),
  );
  await messagesRepo.create(message);
}
