import '../modal/author_name.dart';
import '../modal/board.type.dart';
import '../modal/content.dart';
import '../modal/message.type.dart';

class Message {
  final MessageId id;
  final BoardId boardId;
  final Content content;
  final AuthorName? authorName;

  Message({
    required this.id,
    required this.boardId,
    required this.content,
    this.authorName,
  });
}
