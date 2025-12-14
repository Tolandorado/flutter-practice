import 'string_identity.mixin.dart';

class BoardId with StringIdentity {
  final String _value;

  const BoardId(this._value);

  @override
  String get value => _value;
}

class Board {
  final BoardId id;
  final String title;

  Board({required this.id, required this.title});
}
