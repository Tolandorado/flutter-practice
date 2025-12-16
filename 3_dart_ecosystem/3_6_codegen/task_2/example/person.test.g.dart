// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
    name: json['name'] as String,
    birthday: DateTime.parse(json['birthday'] as String),
  );
}

Map<String, dynamic> _$PersonToJson(Person instance) {
  final val = <String, dynamic>{};
  val['name'] = instance.name;
  val['birthday'] = instance.birthday.toIso8601String();
  return val;
}
