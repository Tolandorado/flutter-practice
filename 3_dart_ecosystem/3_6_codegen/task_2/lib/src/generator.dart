import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'annotations.dart';

class JsonSerializableGenerator
    extends GeneratorForAnnotation<JsonSerializable> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'Target is not a class',
        element: element,
      );
    }

    final classElement = element;
    final className = classElement.name;

    final fields = classElement.fields
        .where((field) => !field.isStatic)
        .toList();

    final fromJsonBuffer = StringBuffer();
    fromJsonBuffer.writeln(
      '$className _\$${className}FromJson(Map<String, dynamic> json) {',
    );
    fromJsonBuffer.writeln('  return $className(');
    for (final field in fields) {
      final fieldName = field.name;
      final fieldType = field.type.getDisplayString(withNullability: true);

      if (fieldType == 'DateTime?') {
        fromJsonBuffer.writeln(
          "    $fieldName: json['$fieldName'] == null ? null : DateTime.parse(json['$fieldName'] as String),",
        );
      } else if (fieldType == 'DateTime') {
        fromJsonBuffer.writeln(
          "    $fieldName: DateTime.parse(json['$fieldName'] as String),",
        );
      } else {
        fromJsonBuffer.writeln(
          "    $fieldName: json['$fieldName'] as $fieldType,",
        );
      }
    }
    fromJsonBuffer.writeln('  );');
    fromJsonBuffer.writeln('}');

    final toJsonBuffer = StringBuffer();
    toJsonBuffer.writeln(
      'Map<String, dynamic> _\$${className}ToJson($className instance) {',
    );
    toJsonBuffer.writeln('  final val = <String, dynamic>{};');
    for (final field in fields) {
      final fieldName = field.name;
      final fieldType = field.type.getDisplayString(withNullability: true);

      if (fieldType == 'DateTime?') {
        toJsonBuffer.writeln(
          "  val['$fieldName'] = instance.$fieldName?.toIso8601String();",
        );
      } else if (fieldType == 'DateTime') {
        toJsonBuffer.writeln(
          "  val['$fieldName'] = instance.$fieldName.toIso8601String();",
        );
      } else if (field.type.element is ClassElement &&
          (field.type.element as ClassElement).methods.any(
            (method) => method.name == 'toJson',
          )) {
        toJsonBuffer.writeln(
          "  val['$fieldName'] = instance.$fieldName?.toJson();",
        );
      } else {
        toJsonBuffer.writeln("  val['$fieldName'] = instance.$fieldName;");
      }
    }
    toJsonBuffer.writeln('  return val;');
    toJsonBuffer.writeln('}');

    return '''
${fromJsonBuffer.toString()}

${toJsonBuffer.toString()}
''';
  }
}
