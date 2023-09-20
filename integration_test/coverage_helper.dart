import 'dart:io';

void removeCoverageFile(String fileName) {
  final lcovFilePath = 'coverage/lcov.info';

  final lcovFile = File(lcovFilePath);

  if (!lcovFile.existsSync()) {
    print('Arquivo $lcovFilePath não encontrado.');
    return;
  }

  final lines = lcovFile.readAsLinesSync();

  final modifiedLines = <String>[];
  bool shouldRemove = false;

  for (final line in lines) {
    if (line.startsWith('SF:$fileName')) {
      shouldRemove = true;
      continue;
    }

    if (shouldRemove && line.startsWith('end_of_record')) {
      shouldRemove = false;
      continue;
    }

    if (!shouldRemove) {
      modifiedLines.add(line);
    }
  }

  lcovFile.writeAsStringSync(modifiedLines.join('\n'));

  print('Arquivo $fileName removido do relatório de cobertura.');
}

void main() {
  // ignore: unnecessary_string_escapes
  removeCoverageFile('lib\\pages\\detail\\stores\\detail.store.g.dart');
  removeCoverageFile('lib\\pages\\home\\stores\\home.store.g.dart');
}