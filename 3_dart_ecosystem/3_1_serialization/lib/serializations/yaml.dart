import 'model/serializer.dart';
import 'model/request/request.dart';

class YamlSerializer implements Serializer<Request> {
  @override
  String serialize(Request request) {
    final StringBuffer yaml = StringBuffer();
    yaml.writeln('type: "${request.type}"');

    yaml.writeln('stream:');
    final streamYaml =
        StreamInfoYamlSerializer().serialize(request.stream).trimRight();
    yaml.writeln(streamYaml);

    yaml.writeln('gifts:');
    for (var gift in request.gifts) {
      final giftYaml = GiftYamlSerializer().serialize(gift);
      final lines = giftYaml.split('\n');
      if (lines.isNotEmpty) {
        yaml.writeln('  - ${lines.first}');
        for (var i = 1; i < lines.length; i++) {
          yaml.writeln('    ${lines[i]}');
        }
      }
    }
    yaml.writeln('debug:');
    yaml.writeln(DebugInfoYamlSerializer()
        .serialize(request.debug)
        .replaceAll(RegExp(r'^\s*', multiLine: true), '  '));

    return yaml.toString();
  }
}

class StreamInfoYamlSerializer implements Serializer<StreamInfo> {
  @override
  String serialize(StreamInfo streamInfo) {
    final StringBuffer yaml = StringBuffer();
    yaml.writeln('  user_id: "${streamInfo.userId}"');
    yaml.writeln('  is_private: ${streamInfo.isPrivate}');
    yaml.writeln('  settings: ${streamInfo.settings}');
    yaml.writeln('  shard_url: "${streamInfo.shardUrl}"');
    yaml.writeln('  public_tariff:');
    yaml.writeln(PublicTariffYamlSerializer()
        .serialize(streamInfo.publicTariff)
        .replaceAll(RegExp(r'^\s*', multiLine: true), '    '));
    yaml.writeln('  private_tariff:');
    yaml.writeln(PrivateTariffYamlSerializer()
        .serialize(streamInfo.privateTariff)
        .replaceAll(RegExp(r'^\s*', multiLine: true), '    '));
    return yaml.toString();
  }
}

class PublicTariffYamlSerializer implements Serializer<PublicTariff> {
  @override
  String serialize(PublicTariff publicTariff) {
    final DurationConverter durationConverter = DurationConverter();
    final String durationString =
        durationConverter.toJson(publicTariff.duration);
    return 'id: ${publicTariff.id}\nprice: ${publicTariff.price}\nduration: "$durationString"\ndescription: "${publicTariff.description}"';
  }
}

class PrivateTariffYamlSerializer implements Serializer<PrivateTariff> {
  @override
  String serialize(PrivateTariff privateTariff) {
    final DurationConverter durationConverter = DurationConverter();
    final String durationString =
        durationConverter.toJson(privateTariff.duration);
    return 'client_price: ${privateTariff.clientPrice}\nduration: "$durationString"\ndescription: "${privateTariff.description}"';
  }
}

class GiftYamlSerializer implements Serializer<Gift> {
  @override
  String serialize(Gift gift) {
    return 'id: ${gift.id}\nprice: ${gift.price}\ndescription: "${gift.description}"';
  }
}

class DebugInfoYamlSerializer implements Serializer<DebugInfo> {
  @override
  String serialize(DebugInfo debugInfo) {
    final DurationConverter durationConverter = DurationConverter();
    final String durationString = durationConverter.toJson(debugInfo.duration);
    final String atString = debugInfo.at.toUtc().toIso8601String();
    return 'duration: "$durationString"\nat: $atString';
  }
}
