import 'package:task_2/src/annotations.dart';

part 'tree.test.g.dart';

@JsonSerializable()
class TreeItem {
  const TreeItem({required this.value, required this.treeItem});
  final String value;
  final TreeItem? treeItem;

  factory TreeItem.fromJson(Map<String, dynamic> json) =>
      _$TreeItemFromJson(json);
  Map<String, dynamic> toJson() => _$TreeItemToJson(this);
}

void main() {
  TreeItem person = TreeItem(
    value: '1',
    treeItem: TreeItem(
      value: '2',
      treeItem: TreeItem(value: '3', treeItem: null),
    ),
  );
  print(person.toJson());
}
