import 'package:flutter_test/flutter_test.dart';
import 'package:custom_state_management/custom_state_management.dart';
import 'package:flutter/widgets.dart';

void main() {
  group('StateNotifier Tests', () {
    late StateNotifier<int> counterNotifier;

    setUp(() {
      counterNotifier = StateNotifier<int>(initialValue: 0);
    });

    tearDown(() {
      counterNotifier.dispose();
    });

    test('initial value is set correctly', () {
      expect(counterNotifier.value, equals(0));
    });

    test('update changes value and notifies listeners', () {
      int? listenerValue;
      counterNotifier.addListener((value) => listenerValue = value);

      counterNotifier.update((value) => value + 1);

      expect(counterNotifier.value, equals(1));
      expect(listenerValue, equals(1));
    });

    test('updateAsync changes value and notifies listeners', () async {
      int? listenerValue;
      counterNotifier.addListener((value) => listenerValue = value);

      await counterNotifier.updateAsync((value) async {
        await Future.delayed(Duration(milliseconds: 100));
        return value + 1;
      });

      expect(counterNotifier.value, equals(1));
      expect(listenerValue, equals(1));
    });

    test('multiple listeners are notified', () {
      int listenerCount1 = 0;
      int listenerCount2 = 0;

      counterNotifier.addListener((_) => listenerCount1++);
      counterNotifier.addListener((_) => listenerCount2++);

      counterNotifier.update((value) => value + 1);

      expect(listenerCount1, equals(1));
      expect(listenerCount2, equals(1));
    });

    test('removed listener is not notified', () {
      int listenerCount = 0;
      void listener(int _) => listenerCount++;

      counterNotifier.addListener(listener);
      counterNotifier.removeListener(listener);

      counterNotifier.update((value) => value + 1);

      expect(listenerCount, equals(0));
    });

    test('stream emits updated values', () async {
      expect(
        counterNotifier.stream,
        emitsInOrder([1, 2, 3]),
      );

      counterNotifier.update((value) => value + 1);
      counterNotifier.update((value) => value + 1);
      counterNotifier.update((value) => value + 1);
    });

    test('dispose clears listeners and closes stream', () {
      int listenerCount = 0;
      counterNotifier.addListener((_) => listenerCount++);

      // First verify the stream is working
      expect(
        counterNotifier.stream,
        emits(1),
      );

      counterNotifier.update((value) => value + 1);
      expect(listenerCount, equals(1));

      // Now dispose
      counterNotifier.dispose();

      // Verify that the stream is closed by trying to listen to it
      expect(
        () => counterNotifier.stream.listen((_) {}),
        throwsStateError,
      );

      // Verify listeners are cleared
      expect(
          listenerCount, equals(1)); // Count should not increase after dispose
    });
  });

  group('StateListener Tests', () {
    late StateNotifier<int> counterNotifier;

    setUp(() {
      counterNotifier = StateNotifier<int>(initialValue: 0);
    });

    tearDown(() {
      counterNotifier.dispose();
    });

    testWidgets('StateListener rebuilds when notifier updates', (tester) async {
      int buildCount = 0;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: StateListener<int>(
            notifier: counterNotifier,
            builder: (context, value) {
              buildCount++;
              return Text('$value');
            },
          ),
        ),
      );

      expect(buildCount, equals(1));
      expect(find.text('0'), findsOneWidget);

      counterNotifier.update((value) => value + 1);
      await tester.pump();

      expect(buildCount, equals(2));
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('StateListener removes listener on dispose', (tester) async {
      int buildCount = 0;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: StateListener<int>(
            notifier: counterNotifier,
            builder: (context, value) {
              buildCount++;
              return Text('$value');
            },
          ),
        ),
      );

      // Verify initial build
      expect(buildCount, equals(1));

      // Dispose the widget
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(),
        ),
      );

      // Update the notifier
      counterNotifier.update((value) => value + 1);
      await tester.pump();

      // Verify that no rebuild occurred after disposal
      expect(buildCount, equals(1));
    });
  });
}
