import 'string_identity.mixin.dart';

class MessageId with StringIdentity {
  final String _value;

  const MessageId(this._value);

  @override
  String get value => _value;
}
