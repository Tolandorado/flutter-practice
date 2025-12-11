// Native implementation of [CustomDateTime].
class CustomDateTime {
  final DateTime _nativeDateTime;

  CustomDateTime.now() : _nativeDateTime = DateTime.now();

  CustomDateTime.fromMicrosecondsSinceEpoch(int microseconds)
    : _nativeDateTime = DateTime.fromMicrosecondsSinceEpoch(microseconds);

  // Delegated properties
  int get microsecond => _nativeDateTime.microsecond;
  int get microsecondsSinceEpoch => _nativeDateTime.microsecondsSinceEpoch;
  int get year => _nativeDateTime.year;
  int get month => _nativeDateTime.month;
  int get day => _nativeDateTime.day;
  int get hour => _nativeDateTime.hour;
  int get minute => _nativeDateTime.minute;
  int get second => _nativeDateTime.second;
  int get millisecond => _nativeDateTime.millisecond;
  int get weekday => _nativeDateTime.weekday;

  // Delegated methods
  CustomDateTime add(Duration duration) {
    return CustomDateTime.fromMicrosecondsSinceEpoch(
      (_nativeDateTime.add(duration)).microsecondsSinceEpoch,
    );
  }

  CustomDateTime subtract(Duration duration) {
    return CustomDateTime.fromMicrosecondsSinceEpoch(
      (_nativeDateTime.subtract(duration)).microsecondsSinceEpoch,
    );
  }

  bool isAfter(CustomDateTime other) =>
      _nativeDateTime.isAfter(other._nativeDateTime);

  bool isBefore(CustomDateTime other) =>
      _nativeDateTime.isBefore(other._nativeDateTime);

  bool isAtSameMomentAs(CustomDateTime other) =>
      _nativeDateTime.isAtSameMomentAs(other._nativeDateTime);

  int compareTo(CustomDateTime other) =>
      _nativeDateTime.compareTo(other._nativeDateTime);

  @override
  String toString() {
    return _nativeDateTime.toIso8601String();
  }
}
