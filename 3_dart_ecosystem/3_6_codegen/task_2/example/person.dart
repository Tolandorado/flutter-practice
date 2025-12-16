import 'package:task_2/src/annotations.dart';

part 'person.test.g.dart';

@JsonSerializable()
class Person {
  const Person({required this.name, required this.birthday});
  final String name;
  final DateTime birthday;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}

// void main() {
//   Person person = Person(name: 'John Doe', birthday: DateTime(2000, 1, 1));
//   print(person.toJson());
// }
