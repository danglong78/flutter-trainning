import 'dart:async';
import 'dart:collection';

class ThreadPool<T, V> {
  final Queue<T> _input = Queue();
  StreamController<V> _streamController = StreamController.broadcast();
  final Future<V> Function(T) task;

  final int maxConcurrentTasks;

  int runningTasks = 0;

  ThreadPool(this.task, {this.maxConcurrentTasks = 3});

  Stream<V> get stream => _streamController.stream;

  get isDone => _streamController.done;

  void addAll(Iterable<T> iterable) {
    _input.addAll(iterable);
    if (_streamController.isClosed) _streamController = StreamController.broadcast();
    _startExecution();
  }

  void _startExecution() {
    if (runningTasks == maxConcurrentTasks || _input.isEmpty) {
      return;
    }
    while (_input.isNotEmpty && runningTasks < maxConcurrentTasks) {
      runningTasks++;
      print('Concurrent workers: $runningTasks');
      _runTask();
    }
  }

  void _runTask() {
    task(_input.removeFirst()).then((value) async {
      _streamController.add(value);
    }).catchError((err) {
      _streamController.addError(err);
    }).whenComplete(() async {
      if (_input.isNotEmpty && runningTasks < maxConcurrentTasks) {
        _runTask();
      } else {
        runningTasks--;
        print('Concurrent workers: $runningTasks');
        if (runningTasks == 0) {
          _streamController.close();
        }
      }
    });
  }
}
