// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) => Request(
      type: json['type'] as String,
      stream: StreamInfo.fromJson(json['stream'] as Map<String, dynamic>),
      gifts: (json['gifts'] as List<dynamic>)
          .map((e) => Gift.fromJson(e as Map<String, dynamic>))
          .toList(),
      debug: DebugInfo.fromJson(json['debug'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      'type': instance.type,
      'stream': instance.stream.toJson(),
      'gifts': instance.gifts.map((e) => e.toJson()).toList(),
      'debug': instance.debug.toJson(),
    };

StreamInfo _$StreamInfoFromJson(Map<String, dynamic> json) => StreamInfo(
      userId: json['user_id'] as String,
      isPrivate: json['is_private'] as bool,
      settings: (json['settings'] as num).toInt(),
      shardUrl: json['shard_url'] as String,
      publicTariff:
          PublicTariff.fromJson(json['public_tariff'] as Map<String, dynamic>),
      privateTariff: PrivateTariff.fromJson(
          json['private_tariff'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StreamInfoToJson(StreamInfo instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'is_private': instance.isPrivate,
      'settings': instance.settings,
      'shard_url': instance.shardUrl,
      'public_tariff': instance.publicTariff.toJson(),
      'private_tariff': instance.privateTariff.toJson(),
    };

PublicTariff _$PublicTariffFromJson(Map<String, dynamic> json) => PublicTariff(
      id: (json['id'] as num).toInt(),
      price: (json['price'] as num).toInt(),
      duration: const DurationConverter().fromJson(json['duration'] as String),
      description: json['description'] as String,
    );

Map<String, dynamic> _$PublicTariffToJson(PublicTariff instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'duration': const DurationConverter().toJson(instance.duration),
      'description': instance.description,
    };

PrivateTariff _$PrivateTariffFromJson(Map<String, dynamic> json) =>
    PrivateTariff(
      clientPrice: (json['client_price'] as num).toInt(),
      duration: const DurationConverter().fromJson(json['duration'] as String),
      description: json['description'] as String,
    );

Map<String, dynamic> _$PrivateTariffToJson(PrivateTariff instance) =>
    <String, dynamic>{
      'client_price': instance.clientPrice,
      'duration': const DurationConverter().toJson(instance.duration),
      'description': instance.description,
    };

Gift _$GiftFromJson(Map<String, dynamic> json) => Gift(
      id: (json['id'] as num).toInt(),
      price: (json['price'] as num).toInt(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$GiftToJson(Gift instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'description': instance.description,
    };

DebugInfo _$DebugInfoFromJson(Map<String, dynamic> json) => DebugInfo(
      duration: const DurationConverter().fromJson(json['duration'] as String),
      at: DateTime.parse(json['at'] as String),
    );

Map<String, dynamic> _$DebugInfoToJson(DebugInfo instance) => <String, dynamic>{
      'duration': const DurationConverter().toJson(instance.duration),
      'at': instance.at.toIso8601String(),
    };
