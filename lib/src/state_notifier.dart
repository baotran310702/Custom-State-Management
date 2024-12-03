import 'dart:async';

class StateNotifier<T> {
  T _value;
  bool _disposed = false;

  final List<void Function(T)> _listeners = [];
  final StreamController<T> _streamController = StreamController<T>.broadcast();

  StateNotifier({required T initialValue}) : _value = initialValue;

  T get value => _value;

  void update(T Function(T) update) {
    if (_disposed) return;
    _value = update(_value);
    notifyListeners();
  }

  Future<void> updateAsync(Future<T> Function(T) update) async {
    if (_disposed) return;
    _value = await update(_value);
    notifyListeners();
  }

  void addListener(void Function(T) listener) {
    if (_disposed) return;
    _listeners.add(listener);
  }

  void removeListener(void Function(T) listener) {
    _listeners.remove(listener);
  }

  void notifyListeners() {
    if (_disposed) return;
    for (var listener in _listeners) {
      listener(_value);
    }
    if (!_streamController.isClosed) {
      _streamController.add(_value);
    }
  }

  void dispose() {
    _disposed = true;
    _listeners.clear();
    _streamController.close();
  }

  Stream<T> get stream => _streamController.stream;
}
