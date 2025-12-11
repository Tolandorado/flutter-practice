/// Web implementation of [CustomDateTime].
class CustomDateTime {
  final int microsecondsSinceEpoch;

  CustomDateTime.now()
    : microsecondsSinceEpoch = DateTime.now().microsecondsSinceEpoch;

  CustomDateTime.fromMicrosecondsSinceEpoch(this.microsecondsSinceEpoch);

  // Properties
  int get millisecond {
    final microsInSecond = microsecondsSinceEpoch % 1000000;
    return microsInSecond ~/ 1000;
  }

  int get microsecond {
    final microsInSecond = microsecondsSinceEpoch % 1000000;
    return microsInSecond % 1000;
  }

  // Properties that require a native DateTime object for calculation
  DateTime get _nativeDateTime =>
      DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch);

  int get year => _nativeDateTime.year;
  int get month => _nativeDateTime.month;
  int get day => _nativeDateTime.day;
  int get hour => _nativeDateTime.hour;
  int get minute => _nativeDateTime.minute;
  int get second => _nativeDateTime.second;
  int get weekday => _nativeDateTime.weekday;

  // Methods
  CustomDateTime add(Duration duration) {
    return CustomDateTime.fromMicrosecondsSinceEpoch(
      microsecondsSinceEpoch + duration.inMicroseconds,
    );
  }

  CustomDateTime subtract(Duration duration) {
    return CustomDateTime.fromMicrosecondsSinceEpoch(
      microsecondsSinceEpoch - duration.inMicroseconds,
    );
  }

  bool isAfter(CustomDateTime other) =>
      microsecondsSinceEpoch > other.microsecondsSinceEpoch;

  bool isBefore(CustomDateTime other) =>
      microsecondsSinceEpoch < other.microsecondsSinceEpoch;

  bool isAtSameMomentAs(CustomDateTime other) =>
      microsecondsSinceEpoch == other.microsecondsSinceEpoch;

  int compareTo(CustomDateTime other) =>
      microsecondsSinceEpoch.compareTo(other.microsecondsSinceEpoch);

  @override
  String toString() {
    // Use the native DateTime for formatting up to the second.
    final nativeDt = DateTime.fromMicrosecondsSinceEpoch(
      microsecondsSinceEpoch,
      isUtc: true,
    );
    // toIso8601String() on web gives '...Z'.
    // It will look like '2023-10-27T10:00:00.123Z'. We want to replace the fractional part.
    final iso = nativeDt.toIso8601String();
    final upToSeconds = iso.split('.')[0];

    final micros = microsecondsSinceEpoch % 1000000;
    return '$upToSeconds.${micros.toString().padLeft(6, '0')}Z';
  }
}
