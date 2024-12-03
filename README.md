# 📖 Getting Started

### 1. Register a State
Initialize the `StateManager` and register a state with a default value:

import 'package:flutter_state_manager/flutter_state_manager.dart';

final stateManager = StateManager();
stateManager.registerState<int>('counter', 0);


# 🛠 API Reference

## StateManager
The core class for managing states.

### Methods

| Method             | Description                                       |
|--------------------|---------------------------------------------------|
| `registerState<T>()` | Registers a state with a default value.           |
| `getState<T>()`      | Retrieves the current value of a state.           |
| `updateState<T>()`   | Updates the value of a state.                     |
| `watchState<T>()`    | Returns a stream for listening to state changes.  |
| `resetState<T>()`    | Resets a state to its default value.              |
| `removeState()`      | Removes a state from the manager.                 |
