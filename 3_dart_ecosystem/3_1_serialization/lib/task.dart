import 'package:json_annotation/json_annotation.dart';
import 'dart:io';
import 'dart:convert';
// import 'package:toml/toml.dart';
// import 'package:yaml_writer/yaml_writer.dart';

part 'task.g.dart';

class DurationConverter implements JsonConverter<Duration, String> {
  const DurationConverter();

  @override
  Duration fromJson(String json) {
    if (json.endsWith('h')) {
      return Duration(hours: int.parse(json.replaceAll('h', '')));
    } else if (json.endsWith('m')) {
      return Duration(minutes: int.parse(json.replaceAll('m', '')));
    } else if (json.endsWith('ms')) {
      return Duration(milliseconds: int.parse(json.replaceAll('ms', '')));
    }
    return Duration.zero;
  }

  @override
  String toJson(Duration object) {
    if (object.inHours > 0) {
      return '${object.inHours}h';
    } else if (object.inMinutes > 0) {
      return '${object.inMinutes}m';
    } else {
      return '${object.inMilliseconds}ms';
    }
  }
}

@JsonSerializable(explicitToJson: true)
class Request {
  final String type;
  final StreamInfo stream;
  final List<Gift> gifts;
  final DebugInfo debug;

  Request({
    required this.type,
    required this.stream,
    required this.gifts,
    required this.debug,
  });

  factory Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToJson(this);

  String toToml() {
    final StringBuffer toml = StringBuffer();
    toml.writeln('type = "$type"');

    toml.writeln('[stream]');
    toml.writeln(
        stream.toToml().replaceAll(RegExp(r'^', multiLine: true), '  '));

    for (var gift in gifts) {
      toml.writeln('[[gifts]]');
      toml.writeln(
          gift.toToml().replaceAll(RegExp(r'^', multiLine: true), '  '));
    }

    toml.writeln('[debug]');
    toml.writeln(
        debug.toToml().replaceAll(RegExp(r'^', multiLine: true), '  '));

    return toml.toString();
  }

  String toYaml() {
    final StringBuffer yaml = StringBuffer();
    yaml.writeln('type: "$type"');

    yaml.writeln('stream:');
    yaml.writeln(
        stream.toYaml().replaceAll(RegExp(r'^', multiLine: true), '  '));

    yaml.writeln('gifts:');
    for (var gift in gifts) {
      final giftYaml = gift.toYaml();
      final lines = giftYaml.split('\n');
      if (lines.isNotEmpty) {
        yaml.writeln('  - ${lines.first}');
        for (var i = 1; i < lines.length; i++) {
          yaml.writeln('    ${lines[i]}');
        }
      }
    }

    yaml.writeln('debug:');
    yaml.writeln(
        debug.toYaml().replaceAll(RegExp(r'^', multiLine: true), '  '));

    return yaml.toString();
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class StreamInfo {
  final String userId;
  final bool isPrivate;
  final int settings;
  final String shardUrl;
  final PublicTariff publicTariff;
  final PrivateTariff privateTariff;

  StreamInfo({
    required this.userId,
    required this.isPrivate,
    required this.settings,
    required this.shardUrl,
    required this.publicTariff,
    required this.privateTariff,
  });

  factory StreamInfo.fromJson(Map<String, dynamic> json) =>
      _$StreamInfoFromJson(json);
  Map<String, dynamic> toJson() => _$StreamInfoToJson(this);

  String toToml() {
    final StringBuffer toml = StringBuffer();
    toml.writeln('userId = "$userId"');
    toml.writeln('isPrivate = $isPrivate');
    toml.writeln('settings = $settings');
    toml.writeln('shardUrl = "$shardUrl"');
    toml.writeln('[publicTariff]');
    toml.writeln(
        publicTariff.toToml().replaceAll(RegExp(r'^', multiLine: true), '  '));
    toml.writeln('[privateTariff]');
    toml.writeln(
        privateTariff.toToml().replaceAll(RegExp(r'^', multiLine: true), '  '));
    return toml.toString();
  }

  String toYaml() {
    final StringBuffer yaml = StringBuffer();
    yaml.writeln('userId: "$userId"');
    yaml.writeln('isPrivate: $isPrivate');
    yaml.writeln('settings: $settings');
    yaml.writeln('shardUrl: "$shardUrl"');
    yaml.writeln('publicTariff:');
    yaml.writeln(
        publicTariff.toYaml().replaceAll(RegExp(r'^', multiLine: true), '  '));
    yaml.writeln('privateTariff:');
    yaml.writeln(
        privateTariff.toYaml().replaceAll(RegExp(r'^', multiLine: true), '  '));
    return yaml.toString();
  }
}

@JsonSerializable(explicitToJson: true)
class PublicTariff {
  final int id;
  final int price;
  @DurationConverter()
  final Duration duration;
  final String description;

  PublicTariff({
    required this.id,
    required this.price,
    required this.duration,
    required this.description,
  });

  factory PublicTariff.fromJson(Map<String, dynamic> json) =>
      _$PublicTariffFromJson(json);
  Map<String, dynamic> toJson() => _$PublicTariffToJson(this);

  String toToml() {
    final durationConverter = DurationConverter();
    final durationString = durationConverter.toJson(duration);
    return 'id = $id\nprice = $price\nduration = "$durationString"\ndescription = "$description"';
  }

  String toYaml() {
    final durationConverter = DurationConverter();
    final durationString = durationConverter.toJson(duration);
    return 'id: $id\nprice: $price\nduration: "$durationString"\ndescription: "$description"';
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PrivateTariff {
  final int clientPrice;
  @DurationConverter()
  final Duration duration;
  final String description;

  PrivateTariff({
    required this.clientPrice,
    required this.duration,
    required this.description,
  });

  factory PrivateTariff.fromJson(Map<String, dynamic> json) =>
      _$PrivateTariffFromJson(json);
  Map<String, dynamic> toJson() => _$PrivateTariffToJson(this);

  String toToml() {
    final DurationConverter durationConverter = DurationConverter();
    final String durationString = durationConverter.toJson(duration);
    return 'clientPrice = $clientPrice\nduration = "$durationString"\ndescription = "$description"';
  }

  String toYaml() {
    final DurationConverter durationConverter = DurationConverter();
    final String durationString = durationConverter.toJson(duration);
    return 'clientPrice: $clientPrice\nduration: "$durationString"\ndescription: "$description"';
  }
}

@JsonSerializable(explicitToJson: true)
class Gift {
  final int id;
  final int price;
  final String description;

  Gift({
    required this.id,
    required this.price,
    required this.description,
  });

  factory Gift.fromJson(Map<String, dynamic> json) => _$GiftFromJson(json);

  Map<String, dynamic> toJson() => _$GiftToJson(this);

  String toToml() {
    return 'id = $id\nprice = $price\ndescription = "$description"';
  }

  String toYaml() {
    return 'id: $id\nprice: $price\ndescription: "$description"';
  }
}

@JsonSerializable(explicitToJson: true)
class DebugInfo {
  @DurationConverter()
  final Duration duration;
  final DateTime at;

  DebugInfo({
    required this.duration,
    required this.at,
  });

  factory DebugInfo.fromJson(Map<String, dynamic> json) =>
      _$DebugInfoFromJson(json);
  Map<String, dynamic> toJson() => _$DebugInfoToJson(this);

  String toToml() {
    final DurationConverter durationConverter = DurationConverter();
    final String durationString = durationConverter.toJson(duration);
    final String atString = at.toUtc().toIso8601String(); // RFC 3339 format
    return 'duration = "$durationString"\nat = $atString';
  }

  String toYaml() {
    final DurationConverter durationConverter = DurationConverter();
    final String durationString = durationConverter.toJson(duration);
    final String atString = at.toUtc().toIso8601String(); // ISO 8601 format
    return 'duration: "$durationString"\nat: $atString';
  }
}

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

  final tomlString = request.toToml();
  final yamlString = request.toYaml();

  print('--- YAML ---');
  print(yamlString);
  print('--- TOML ---');
  print(tomlString);
}
