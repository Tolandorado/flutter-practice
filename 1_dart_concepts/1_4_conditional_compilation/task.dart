// import 'dart:io';
import 'custom_date_time.dart';

void main() {
  // Create a native and web implementations for a custom [DateTime], supporting
  // microseconds(unlike the standard DateTime, which doesn't on web).
  // Use conditional compilation to export the class for general
  // use on any platform.
  // print('Running on: ${Platform.operatingSystem}\n');
  final now = CustomDateTime.now();
  print('Current time: $now');
  print('Year: ${now.year}, Month: ${now.month}, Day: ${now.day}');
  print('Weekday: ${now.weekday}');
  print('Microsecond: ${now.microsecond}\n');

  final later = now.add(const Duration(days: 1, hours: 2, minutes: 30));
  print('Later time: $later');
  print('Is later after now? ${later.isAfter(now)}\n');

  final fromMicroseconds = CustomDateTime.fromMicrosecondsSinceEpoch(
    1234567890123,
  );
  print('From microseconds: $fromMicroseconds');
  print('Microsecond from microseconds: ${fromMicroseconds.microsecond}');
}
