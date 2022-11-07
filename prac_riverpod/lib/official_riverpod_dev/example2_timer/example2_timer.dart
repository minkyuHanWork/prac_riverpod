import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class WebsocketClient {
  Stream<int> getCounterStream([int start]);
}

class FakeWebsocketClient implements WebsocketClient {
  @override
  Stream<int> getCounterStream([int start = 0]) async* {
    int i = start;
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield i--;
    }
  }
}

final websocketClientProvider = Provider<WebsocketClient>((ref) {
  return FakeWebsocketClient();
});

final counterProvider =
    StreamProvider.autoDispose.family<int, int>((ref, start) {
  final wsClient = ref.watch(websocketClientProvider);
  return wsClient.getCounterStream(start);
});

class Example2Timer extends ConsumerWidget {
  const Example2Timer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<int> counter = ref.watch(counterProvider(10));

    return Scaffold(
        appBar: AppBar(
          title: const Text('Timer'),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            counter
                .when(
                  data: (int value) {
                    if (value > 0) {
                      return value;
                    } else if (value <= 0) {
                      return 0;
                    }
                  },
                  error: (Object e, _) => e,
                  loading: () => 10,
                )
                .toString(),
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ));
  }
}
