import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cityProvider = Provider<String>((ref) => 'Seoul');

Future<int> fetchTemperature(String city) async {
  await Future.delayed(const Duration(seconds: 1));

  return city == 'Seoul' ? 20 : 15;
}

final futureProvider = FutureProvider<int>((ref) async {
  final city = ref.watch(cityProvider);

  return fetchTemperature(city);
});

class TutCombineProviders extends ConsumerWidget {
  const TutCombineProviders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = ref.watch(futureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Combine Provider'),
      ),
      body: Center(
        child: future.when(
          data: (data) => Text(data.toString()),
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
