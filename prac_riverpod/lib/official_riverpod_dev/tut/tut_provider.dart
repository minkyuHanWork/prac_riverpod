import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final numberProvider = Provider<int>((ref) => 42);

class TutProvider extends StatelessWidget {
  const TutProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider'),
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final number = ref.watch(numberProvider);
            return Text(number.toString(),
                style: Theme.of(context).textTheme.displayMedium);
          },
        ),
      ),
    );
  }
}
