import 'dart:async';
import 'dart:math';

class Server {
  /// [StreamController] simulating an ongoing websocket endpoint.
  StreamController<int>? _controller;

  /// [Timer] periodically adding data to the [_controller].
  Timer? _timer;

  /// Initializes this [Server].
  Future<void> init() async {
    final Random random = Random();

    while (true) {
      _controller = StreamController();
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _controller?.add(timer.tick);
      });

      await Future.delayed(
        Duration(milliseconds: (1000 + (5000 * random.nextDouble())).round()),
      );

      _controller?.addError(DisconnectedException());
      _controller?.close();
      _controller = null;

      _timer?.cancel();
      _timer = null;

      await Future.delayed(
        Duration(milliseconds: (1000 + (5000 * random.nextDouble())).round()),
      );
    }
  }

  /// Returns a [Stream] of data, if this [Server] is up and reachable, or
  /// throws [DisconnectedException] otherwise.
  Future<Stream<int>> connect() async {
    if (_controller != null) {
      return _controller!.stream;
    } else {
      throw DisconnectedException();
    }
  }
}

class DisconnectedException implements Exception {}

Future<T> retry<T>(
  Future<T> Function() computation, {
  required bool Function(Exception e) retryIf,
  Duration maxDelay = const Duration(seconds: 30),
  double backoffFactor = 1.5,
}) async {
  var delay = Duration(seconds: 1);
  while (true) {
    try {
      return await computation();
    } on Exception catch (e) {
      if (!retryIf(e)) {
        rethrow;
      }
      print('Operation failed. Retrying in ${delay.inSeconds}s...');
      await Future.delayed(delay);
      delay = Duration(
        milliseconds: (delay.inMilliseconds * backoffFactor).round(),
      );
      if (delay > maxDelay) {
        delay = maxDelay;
      }
    }
  }
}

class Client {
  Future<void> connect(Server server) async {
    // TODO: Implement backoff re-connecting.
    //       Data from the [server] should be printed to the console.
    await retry(() async {
      print('Attempting to connect...');
      final stream = await server.connect();
      print('Connection successful. Listening for data...');
      final completer = Completer<void>();
      final subscription = stream.listen(
        (data) {
          print('Received: $data');
        },
        onError: (error) {
          print('Stream error: $error');
          if (!completer.isCompleted) {
            completer.complete();
          }
        },
        onDone: () {
          if (!completer.isCompleted) {
            completer.complete();
          }
        },
      );
      await completer.future;
      await subscription.cancel();
      throw DisconnectedException();
    }, retryIf: (e) => e is DisconnectedException);
  }
}

Future<void> main() async {
  Client()..connect(Server()..init());
}
