import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final streamProvider = StreamProvider.autoDispose<String>((ref) =>
    Stream.periodic(const Duration(milliseconds: 400), (count) => '$count'));

class TutStreamProvider extends ConsumerWidget {
  const TutStreamProvider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Provider'),
      ),
      body: Center(
        child: buildStreamBuilder(context, ref),
      ),
    );
  }

  Widget buildStreamBuilder(BuildContext context, WidgetRef ref) {
    final stream = ref.watch(streamProvider);

    return stream.when(data: (value) {
      return Text(
        value,
        style: Theme.of(context).textTheme.displaySmall,
      );
    }, error: (error, stackTrace) {
      return Text('Error : $error',
          style: Theme.of(context).textTheme.displaySmall);
    }, loading: () {
      return const CircularProgressIndicator();
    });

    // return StreamBuilder<String>(
    //   stream: stream,
    //   builder: (context, snapshot) {
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.waiting:
    //         return const CircularProgressIndicator();
    //       default:
    //         if (snapshot.hasError) {
    //           return Text(
    //             'Error : ${snapshot.error}',
    //             style: Theme.of(context).textTheme.displaySmall,
    //           );
    //         } else {
    //           final counter = snapshot.data;
    //           return Text(
    //             counter.toString(),
    //             style: Theme.of(context).textTheme.displaySmall,
    //           );
    //         }
    //     }
    //   },
    // );
  }
}
