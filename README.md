# Custom State Management for Flutter

A lightweight and efficient state management solution for Flutter applications that provides simple state handling without external dependencies.

## Features

- 🎯 **Simple API**: Manage application state with an intuitive and straightforward API.
- ⚡ **Synchronous and Asynchronous Updates**: Update state both synchronously and asynchronously with ease.
- 🔄 **Stream-based State Listening**: Listen to state changes using streams for reactive programming.
- 🎨 **Widget Rebuilding Optimization**: Efficiently rebuild widgets only when necessary, improving performance.
- 🛡️ **Memory Leak Prevention**: Automatically manage listeners to prevent memory leaks.

## Installation

Add the following to your `pubspec.yaml`:

````

### Explanation

- **Features**: Expanded to provide more context on each feature.
- **Installation**: Added instructions for adding the package to a Flutter project.
- **Usage**: Detailed examples for using `StateNotifier`, `StateListener`, and `StateManager`.
- **Contributing and License**: Added sections for contributing and licensing information.

This detailed README should help users understand how to integrate and use your custom state management solution in their Flutter applications.

## Usage

### StateNotifier

The `StateNotifier` class is the core of this state management solution. It holds a piece of state and notifies listeners when the state changes.

- **Creating a StateNotifier**:
  ```dart
  final counterNotifier = StateNotifier<int>(initialValue: 0);
````

- **Updating State**:

  ```dart
  counterNotifier.update((value) => value + 1);
  ```

- **Listening to State Changes**:

  ```dart
  counterNotifier.addListener((value) {
    print('Counter updated: $value');
  });
  ```

- **Using Streams**:
  ```dart
  counterNotifier.stream.listen((value) {
    print('Stream value: $value');
  });
  ```

### StateListener

The `StateListener` widget listens to a `StateNotifier` and rebuilds its child widget whenever the state changes.

- **Using StateListener**:
  ```dart
  StateListener<int>(
    notifier: counterNotifier,
    builder: (context, value) {
      return Text('Counter: $value');
    },
  );
  ```

### StateManager

The `StateManager` class is a singleton that manages multiple `StateNotifier` instances, each identified by a unique key.

- **Registering a State**:

  ```dart
  StateManager<int>().registerState('counter', 0);
  ```

- **Retrieving a StateNotifier**:

  ```dart
  final counterNotifier = StateManager<int>().getStateNotifier('counter');
  ```

- **Resetting All States**:
  ```dart
  StateManager<int>().resetAllStates();
  ```

## Contributing

Contributions are welcome! Please submit a pull request or open an issue to discuss any changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
