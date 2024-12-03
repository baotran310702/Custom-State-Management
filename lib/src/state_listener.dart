import 'package:flutter/widgets.dart';
import 'state_notifier.dart';

class StateListener<T> extends StatefulWidget {
  final StateNotifier<T> notifier;
  final Widget Function(BuildContext context, T value) builder;

  const StateListener({
    super.key,
    required this.notifier,
    required this.builder,
  });

  @override
  State<StateListener<T>> createState() => _StateListenerState<T>();
}

class _StateListenerState<T> extends State<StateListener<T>> {
  late T _value;

  @override
  void initState() {
    super.initState();
    _value = widget.notifier.value;
    widget.notifier.addListener(_onValueChanged);
  }

  @override
  void dispose() {
    widget.notifier.removeListener(_onValueChanged);
    super.dispose();
  }

  void _onValueChanged(T value) {
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _value);
  }
}
