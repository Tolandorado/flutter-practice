void main() {
  // Implement a method, returning the maximum element from a `Comparable` list.
  // You must use generics to allow different types usage with that method.
  T maxListValue<T extends Comparable<T>>(List<T> list) {
    if (list.isEmpty) {
      throw ArgumentError('List must not be empty');
    }

    T max = list.first;

    for (final item in list) {
      if (item.compareTo(max) > 0) {
        max = item;
      }
    }

    return max;
  }

  print(maxListValue([1, 2, 5, 4]));
}
