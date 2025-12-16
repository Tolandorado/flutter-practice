import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:glob/glob.dart';

class SummaryBuilder extends Builder {
  @override
  Map<String, List<String>> get buildExtensions => {
    '\$package\$': ['summary.g'],
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final dartFiles = await buildStep.findAssets(Glob('**.dart')).toList();

    final lineCounts = <String, int>{};
    int totalLines = 0;
    for (final assetId in dartFiles) {
      final content = await buildStep.readAsString(assetId);
      final lines = content.split('\n');
      final count = lines.length;
      lineCounts[assetId.path] = count;
      totalLines += count;
    }

    final sortedFiles = lineCounts.entries
        .sorted((a, b) => b.value.compareTo(a.value))
        .toList();

    final outputContent = StringBuffer()
      ..writeln('Total lines of code: $totalLines')
      ..writeln()
      ..writeln('Lines of code by a file in descending order:');
    for (int i = 0; i < sortedFiles.length; i++) {
      final entry = sortedFiles[i];
      final fileName = entry.key.substring(entry.key.lastIndexOf('/') + 1);
      outputContent.writeln('${i + 1}. $fileName: ${entry.value}');
    }

    await buildStep.writeAsString(
      AssetId(buildStep.inputId.package, 'summary.g'),
      outputContent.toString(),
    );
  }
}

Builder summaryBuilder(BuilderOptions options) => SummaryBuilder();
