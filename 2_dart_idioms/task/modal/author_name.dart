class AuthorName {
  final String _value;

  AuthorName(this._value) {
    if (_value.trim().isEmpty) {
      throw ArgumentError('Author name cannot be empty');
    }
  }

  String get value => _value;
}
