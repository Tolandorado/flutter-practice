import 'dart:async';
import 'dart:isolate';
// import 'dart:math';

class IsolateArguments {
  final int start;
  final int end;
  final SendPort sendPort;

  IsolateArguments(this.start, this.end, this.sendPort);
}

// Readabe, but slower:
//Time taken: ~161
// bool _isPrime(int n) {
//   if (n < 2) return false;
//   if (n == 2) return true;
//   if (n % 2 == 0) return false;
//   final int limit = sqrt(n).floor();
//   for (int i = 3; i <= limit; i += 2) {
//     if (n % i == 0) return false;
//   }
//   return true;
// }

//Time taken: ~115
bool isPrime(int n) {
  if (n <= 1) return false;
  if (n <= 3) return true;
  if (n % 2 == 0 || n % 3 == 0) return false;
  for (int i = 5; i * i <= n; i = i + 6) {
    if (n % i == 0 || n % (i + 2) == 0) return false;
  }
  return true;
}

void sumPrimesIsolate(IsolateArguments args) {
  int sum = 0;
  for (int i = args.start; i <= args.end; i++) {
    if (isPrime(i)) {
      sum += i;
    }
  }
  args.sendPort.send(sum);
}

Future<int> calculateSumOfPrimes(int N, int numIsolates) async {
  final receivePort = ReceivePort();
  int totalSum = 0;
  int isolatesFinished = 0;
  final completer = Completer<void>();

  final subscription = receivePort.listen((message) {
    if (message is int) {
      totalSum += message;
      isolatesFinished++;
      if (isolatesFinished == numIsolates) {
        completer.complete();
      }
    }
  });

  final int rangeSize = N ~/ numIsolates;

  for (int i = 0; i < numIsolates; i++) {
    final int start = i * rangeSize + 1;
    final int end = (i == numIsolates - 1) ? N : (i + 1) * rangeSize;
    await Isolate.spawn(
      sumPrimesIsolate,
      IsolateArguments(start, end, receivePort.sendPort),
    );
  }

  await completer.future;
  await subscription.cancel();
  receivePort.close();
  return totalSum;
}

Future<void> main() async {
  final execTimer = Stopwatch()..start();

  const int N = 10000000;
  const int numIsolates = 90;

  print('Calculating sum of primes up to $N using $numIsolates isolates...');

  final totalSum = await calculateSumOfPrimes(N, numIsolates);

  execTimer.stop();

  print('Total sum of primes: $totalSum');
  print('Time taken: ${execTimer.elapsedMilliseconds}');
}
