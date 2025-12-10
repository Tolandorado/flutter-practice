extension ParseLink on String {
  List<dynamic> parseLink() {
    final linkRegex = RegExp(
      r'(https?:\/\/[^\s]+|[\w\.-]+\.[a-z]{2,})',
      caseSensitive: false,
    );
    final matches = linkRegex.allMatches(this);
    List<dynamic> result = [];
    int lastIndex = 0;

    for (final match in matches) {
      if (match.start > lastIndex) {
        result.add(TextPart(this.substring(lastIndex, match.start)));
      }
      result.add(LinkPart(match.group(0)!));
      lastIndex = match.end;
    }

    if (lastIndex < this.length) {
      result.add(TextPart(this.substring(lastIndex)));
    }
    return result;
  }
}

class TextPart {
  final String text;
  TextPart(this.text);

  @override
  String toString() => "Text($text)";
}

class LinkPart {
  final String link;
  LinkPart(this.link);

  @override
  String toString() => "Link($link)";
}

void main() {
  // Implement an extension on [String], parsing links from a text.
  //
  // Extension should return a [List] of texts and links, e.g.:
  // - `Hello, google.com, yay` ->
  //   [Text('Hello, '), Link('google.com'), Text(', yay')].
  String str = 'Hello, google.com, yay';
  print(str.parseLink());
}
