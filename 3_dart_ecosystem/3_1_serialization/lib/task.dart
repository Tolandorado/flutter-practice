import 'dart:io';
import 'dart:convert';
// import 'package:toml/toml.dart';
// import 'package:yaml_writer/yaml_writer.dart';
import 'serializations/model/request/request.dart';
import 'serializations/toml.dart';
import 'serializations/yaml.dart';





void main() {
  // Write a program which deserializes the `request.json` into a `Request`
  // class and prints out its serialization in YAML and TOML formats.
  // Consider to choose correct and accurate types for data representation.
  final file = File('request.json');
  if (!file.existsSync()) {
    print(
        'Ошибка: файл request.json не найден. Убедитесь, что он находится в корневой папке проекта.');
    return;
  }

  final jsonString = file.readAsStringSync();
  final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
  final request = Request.fromJson(jsonMap);

  final tomlString = TomlSerializer().serialize(request);
  final yamlString = YamlSerializer().serialize(request);

  print('--- YAML ---');
  print(yamlString);
  print('--- TOML ---');
  print(tomlString);
}
