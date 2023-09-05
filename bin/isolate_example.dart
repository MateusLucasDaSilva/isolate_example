import 'dart:isolate';

Future<void> main(List<String> arguments) async {
  final isolateExample = IsolateExample();
  isolateExample.createIsolate();
}

class IsolateExample {
  late ReceivePort receivePort;

  Future<void> createIsolate() async {
    receivePort = ReceivePort();

    await Isolate.spawn(functionIsolate, receivePort.sendPort);

    receivePort.listen((message) {
      print(message);
    });
  }
}

Future<void> functionIsolate(SendPort sendPort) async {
  sendPort.send('init Isolate !');

  await Future.delayed(Duration(seconds: 5));

  sendPort.send('finish Isolate!');
}
