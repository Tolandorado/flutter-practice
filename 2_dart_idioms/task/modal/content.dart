class Content {
  final String _value;

  Content(this._value) {
    if (_value.trim().isEmpty) {
      throw ArgumentError('Content of message cannot be empty');
    }
  }

  String get value => _value;
}