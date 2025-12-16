import 'package:flutter_riverpod/legacy.dart';

final CounterProvider = StateNotifierProvider<CounterNotifer, int>((_) {
  return CounterNotifer(0);
});

class CounterNotifer extends StateNotifier<int> {
  CounterNotifer(super.state);

  void increment() => state++;
  void descrement() => state--;
  void reset() => state = 0;
}
