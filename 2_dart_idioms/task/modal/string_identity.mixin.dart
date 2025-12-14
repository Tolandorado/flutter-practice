mixin StringIdentity {
  String get value;

  @override
  bool operator ==(Object other) =>
      other is StringIdentity && other.value == value;

  @override
  int get hashCode => value.hashCode;
}
