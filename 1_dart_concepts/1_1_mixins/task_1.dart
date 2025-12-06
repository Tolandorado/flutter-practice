extension DateTimeToString on DateTime {
  String toFormattedString() {
    final y = year.toString();
    final m = month.toString().padLeft(2, '0');
    final d = day.toString().padLeft(2, '0');
    

    final h = hour.toString().padLeft(2, '0');
    final min = minute.toString().padLeft(2, '0');
    final s = second.toString().padLeft(2, '0');
    
    return "$y.$m.$d $h:$min:$s";
  }
}

void main() {
  // Implement an extension on [DateTime], returning a [String] in format of
  // `YYYY.MM.DD hh:mm:ss` (e.g. `2023.01.01 00:00:00`).
  final date = DateTime.now();  
  print(date.toFormattedString());
}