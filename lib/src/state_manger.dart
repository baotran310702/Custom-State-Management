import 'package:custom_state_management/src/state_notifier.dart';

class StateManager<T> {
  final Map<String, StateNotifier<T>> _states = {};

  static final StateManager _instance = StateManager<dynamic>._internal();

  StateManager._internal();

  factory StateManager() => _instance as StateManager<T>;

  //Đăng ký state
  void registerState(String key, T initialValue) {
    _states[key] = StateNotifier<T>(initialValue: initialValue);
  }

  //Lấy ra state theo key
  StateNotifier<T> getStateNotifier(String key) {
    return _states[key]!;
  }

  //Lấy state theo key
  T getState(String key) {
    return _states[key]!.value;
  }

  //Reset toàn bộ state
  void resetAllStates() {
    for (var state in _states.values) {
      state.dispose();
    }
    _states.clear();
  }

  //Listen state change
  Stream<T> watchState(String key) {
    final stateNotifier = _states[key];
    if (stateNotifier is StateNotifier) {
      return stateNotifier!.stream;
    }
    throw Exception('StateNotifier not found');
  }
}
