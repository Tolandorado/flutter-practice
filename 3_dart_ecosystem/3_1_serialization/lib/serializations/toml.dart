import 'model/serializer.dart';
import 'model/request/request.dart';


class TomlSerializer implements Serializer<Request> {
  @override
  String serialize(Request request) {
    final StringBuffer toml = StringBuffer();
    toml.writeln('type = "${request.type}"');
    toml.writeln('');
    toml.writeln('[stream]');
    toml.writeln(StreamInfoTomlSerializer().serialize(request.stream));
    // .replaceAll(RegExp(r'^\s*', multiLine: true), '  '));

    for (var gift in request.gifts) {
      toml.writeln('[[gifts]]');
      toml.writeln(GiftTomlSerializer().serialize(gift));
      toml.writeln('');
    }

    toml.writeln('[debug]');
    toml.writeln(DebugInfoTomlSerializer().serialize(request.debug));

    return toml.toString();
  }
}

class StreamInfoTomlSerializer implements Serializer<StreamInfo> {
  @override
  String serialize(StreamInfo streamInfo) {
    final StringBuffer toml = StringBuffer();
    toml.writeln('  user_id = "${streamInfo.userId}"');
    toml.writeln('  is_private = ${streamInfo.isPrivate}');
    toml.writeln('  settings = ${streamInfo.settings}');
    toml.writeln('  shard_url = "${streamInfo.shardUrl}"');
    toml.writeln('  [public_tariff]');
    toml.writeln(PublicTariffTomlSerializer()
        .serialize(streamInfo.publicTariff)
        .replaceAll(RegExp(r'^\s*', multiLine: true), '    '));
    toml.writeln('');
    toml.writeln('  [private_tariff]');
    toml.writeln(PrivateTariffTomlSerializer()
        .serialize(streamInfo.privateTariff)
        .replaceAll(RegExp(r'^\s*', multiLine: true), '    '));
    return toml.toString();
  }
}

class PublicTariffTomlSerializer implements Serializer<PublicTariff> {
  @override
  String serialize(PublicTariff publicTariff) {
    final DurationConverter durationConverter = DurationConverter();
    final String durationString =
        durationConverter.toJson(publicTariff.duration);
    return 'id = ${publicTariff.id}\nprice = ${publicTariff.price}\nduration = "$durationString"\ndescription = "${publicTariff.description}"';
  }
}

class PrivateTariffTomlSerializer implements Serializer<PrivateTariff> {
  @override
  String serialize(PrivateTariff privateTariff) {
    final DurationConverter durationConverter = DurationConverter();
    final String durationString =
        durationConverter.toJson(privateTariff.duration);
    return 'client_price = ${privateTariff.clientPrice}\nduration = "$durationString"\ndescription = "${privateTariff.description}"';
  }
}

class GiftTomlSerializer implements Serializer<Gift> {
  @override
  String serialize(Gift gift) {
    return 'id = ${gift.id}\nprice = ${gift.price}\ndescription = "${gift.description}"';
  }
}

class DebugInfoTomlSerializer implements Serializer<DebugInfo> {  @override
  String serialize(DebugInfo debugInfo) {
    final DurationConverter durationConverter = DurationConverter();
    final String durationString = durationConverter.toJson(debugInfo.duration);
    final String atString = debugInfo.at.toUtc().toIso8601String();
    return 'duration = "$durationString"\nat = $atString';
  }
}