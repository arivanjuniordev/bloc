import 'dart:async';

class CounterStream {
  final _streamController = StreamController<int>();
  int _value = 0;

  Sink<int> get input => _streamController.sink;
  Stream<int>? get output => _streamController.stream;

  increment() {
    _streamController.sink.add(_value++);
  }

  void dispose() {
    _streamController.close();
  }
}
