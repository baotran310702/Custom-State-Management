import 'package:custom_state_management/src/state_manger.dart';
import 'package:flutter/material.dart';
import 'package:custom_state_management/custom_state_management.dart';

void main() {
  // Initialize the state manager with an initial counter value
  StateManager<int>().registerState('counter', 0);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom State Management Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  void _incrementCounter() {
    // Get the counter state notifier and update its value
    StateManager<int>().getStateNotifier('counter').update(
          (value) => value + 1,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            // Use StateListener to rebuild only when counter changes
            StateListener<int>(
              notifier: StateManager<int>().getStateNotifier('counter'),
              builder: (context, value) {
                return Text(
                  '$value',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
