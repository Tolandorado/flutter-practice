import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final HttpServer server = await HttpServer.bind(
    InternetAddress.loopbackIPv4,
    8080,
  );
  print(
    'Server is running on address ${server.address} with port ${server.port}',
  );
  await for (final HttpRequest request in server) {
    final String path = request.uri.path;
    if (path == '/read') {
      final File file = File('dummy.txt');
      if (await file.exists()) {
        final String contents = await file.readAsString();
        request.response.statusCode = HttpStatus.ok;
        request.response.headers.contentType = ContentType.text;
        request.response.write(contents);
      } else {
        request.response.statusCode = HttpStatus.notFound;
        request.response.headers.contentType = ContentType.text;
        request.response.write('dummy.txt not found');
      }
      await request.response.close();
      continue;
    }

    final String body = await utf8.decoder.bind(request).join();

    final File file = File('dummy.txt');
    await file.writeAsString(body, mode: FileMode.append);
    request.response.statusCode = HttpStatus.ok;
    request.response.headers.contentType = ContentType.text;
    request.response.write('written');
    await request.response.close();
  }
}
