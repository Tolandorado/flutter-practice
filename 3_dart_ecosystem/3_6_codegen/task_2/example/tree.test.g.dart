// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreeItem _$TreeItemFromJson(Map<String, dynamic> json) {
  return TreeItem(
    value: json['value'] as String,
    treeItem: json['treeItem'] as TreeItem?,
  );
}

Map<String, dynamic> _$TreeItemToJson(TreeItem instance) {
  final val = <String, dynamic>{};
  val['value'] = instance.value;
  val['treeItem'] = instance.treeItem?.toJson();
  return val;
}
