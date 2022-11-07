import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<int> fetchInt() async {
  await Future.delayed(const Duration(seconds: 2));

  return 20;
}

final futureProvider = FutureProvider.autoDispose<int>((ref) => fetchInt());

class TutFutureProvider extends ConsumerWidget {
  const TutFutureProvider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = ref.watch(futureProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Future Provider'),
      ),
      body: Center(
          child: future.when(
              data: (data) => Text(
                    data.toString(),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
              error: (error, stackTrace) {
                return Text(
                  'Error : $error',
                  style: Theme.of(context).textTheme.displaySmall,
                );
              },
              loading: () => const CircularProgressIndicator())),
    );
    ;
  }
}
