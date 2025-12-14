import 'board.dart';
import 'string_identity.mixin.dart';
import 'content.dart';
import 'author_name.dart';

class MessageId with StringIdentity {
  final String _value;

  const MessageId(this._value);

  @override
  String get value => _value;
}

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
