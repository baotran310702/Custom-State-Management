<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>flutter_state_manager</title>
</head>
<body>
    <h1>flutter_state_manager</h1>
    <p>
        <strong>flutter_state_manager</strong> is a lightweight and efficient state management library for Flutter applications. It provides a simple and flexible API to manage state synchronously and asynchronously without relying on external dependencies.
    </p>

    <hr>

    <h2>🌟 Features</h2>
    <ul>
        <li><strong>Easy Integration:</strong> Simplify state management with minimal changes to your app's structure.</li>
        <li><strong>Lightweight and Scalable:</strong> Supports simple states (variables) and complex states (maps, lists, nested states).</li>
        <li><strong>Synchronous and Asynchronous Updates:</strong> Handles both real-time updates and asynchronous data fetches.</li>
        <li><strong>Optimized Performance:</strong> Only updates the UI components affected by state changes, reducing unnecessary re-renders.</li>
        <li><strong>Memory Safe:</strong> Prevents memory leaks and ensures stable performance in long-running applications.</li>
    </ul>

    <hr>

    <h2>🚀 Installation</h2>
    <p>Add this package to your <code>pubspec.yaml</code> file:</p>
    <pre><code>dependencies:

flutter_state_manager: ^1.0.0
</code></pre>

    <p>Or run the command:</p>
    <pre><code>flutter pub add flutter_state_manager</code></pre>

    <hr>

    <h2>📖 Getting Started</h2>

    <h3>1. Register a State</h3>
    <p>Initialize the <code>StateManager</code> and register a state with a default value:</p>
    <pre><code>import 'package:flutter_state_manager/flutter_state_manager.dart';

final stateManager = StateManager();
stateManager.registerState<int>('counter', 0);
</code></pre>

    <h3>2. Access and Update State</h3>
    <p>Use <code>getState</code> to retrieve a state and <code>updateState</code> to update it:</p>
    <pre><code>// Retrieve the current state

final counter = stateManager.getState<int>('counter');

// Update the state
stateManager.updateState<int>('counter', counter + 1);
</code></pre>

    <h3>3. Listen to State Changes</h3>
    <p>Use <code>watchState</code> to listen for state changes and update the UI dynamically:</p>
    <pre><code>StreamBuilder<int>(

stream: stateManager.watchState<int>('counter'),
initialData: stateManager.getState<int>('counter'),
builder: (context, snapshot) {
final counter = snapshot.data ?? 0;
return Text('Counter: $counter');
},
);
</code></pre>

    <h3>4. Reset or Remove State</h3>
    <p>Reset a state to its default value or remove it completely:</p>
    <pre><code>// Reset state

stateManager.resetState<int>('counter');

// Remove state
stateManager.removeState('counter');
</code></pre>

    <hr>

    <h2>📋 Example</h2>
    <p>Here’s a simple counter app using <strong>flutter_state_manager</strong>:</p>
    <pre><code>import 'package:flutter/material.dart';

import 'package:flutter_state_manager/flutter_state_manager.dart';

void main() {
final stateManager = StateManager();
stateManager.registerState<int>('counter', 0);
runApp(MyApp(stateManager));
}

class MyApp extends StatelessWidget {
final StateManager stateManager;

MyApp(this.stateManager);

@override
Widget build(BuildContext context) {
return MaterialApp(
home: Scaffold(
appBar: AppBar(title: Text('State Manager Example')),
body: CounterScreen(stateManager),
),
);
}
}

class CounterScreen extends StatelessWidget {
final StateManager stateManager;

CounterScreen(this.stateManager);

@override
Widget build(BuildContext context) {
return StreamBuilder<int>(
stream: stateManager.watchState<int>('counter'),
initialData: stateManager.getState<int>('counter'),
builder: (context, snapshot) {
final counter = snapshot.data ?? 0;

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Counter: $counter'),
              ElevatedButton(
                onPressed: () {
                  stateManager.updateState<int>('counter', counter + 1);
                },
                child: Text('Increment'),
              ),
            ],
          ),
        );
      },
    );

}
}
</code></pre>

    <hr>

    <h2>🛠 API Reference</h2>
    <p>The core class for managing states:</p>
    <table>
        <thead>
            <tr>
                <th>Method</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><code>registerState&lt;T&gt;()</code></td>
                <td>Registers a state with a default value.</td>
            </tr>
            <tr>
                <td><code>getState&lt;T&gt;()</code></td>
                <td>Retrieves the current value of a state.</td>
            </tr>
            <tr>
                <td><code>updateState&lt;T&gt;()</code></td>
                <td>Updates the value of a state.</td>
            </tr>
            <tr>
                <td><code>watchState&lt;T&gt;()</code></td>
                <td>Returns a stream for listening to state changes.</td>
            </tr>
            <tr>
                <td><code>resetState&lt;T&gt;()</code></td>
                <td>Resets a state to its default value.</td>
            </tr>
            <tr>
                <td><code>removeState()</code></td>
                <td>Removes a state from the manager.</td>
            </tr>
        </tbody>
    </table>

    <hr>

    <h2>📦 Performance Considerations</h2>
    <ul>
        <li><strong>Optimized Rendering:</strong> Only updates UI components affected by the state change.</li>
        <li><strong>Scalability:</strong> Handles multiple state updates efficiently, even in large-scale applications.</li>
        <li><strong>Memory Safety:</strong> Prevents memory leaks by cleaning up unused states.</li>
    </ul>

    <hr>

    <h2>📬 Support</h2>
    <p>If you encounter any issues or have feature requests, please open an issue on the <a href="https://github.com/your_username/flutter_state_manager/issues">GitHub Repository</a>.</p>

    <p>Happy coding! 🎉</p>

</body>
</html>
