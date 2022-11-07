import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Car {
  final int speed;
  final int doors;

  const Car({
    this.speed = 120,
    this.doors = 4,
  });

  Car copy({
    int? speed,
    int? doors,
  }) =>
      Car(
        speed: speed ?? this.speed,
        doors: doors ?? this.doors,
      );
}

class CarNotifier extends StateNotifier<Car> {
  CarNotifier() : super(const Car());

  void setDoors(int doors) {
    final newState = state.copy(doors: doors);
    state = newState;
  }

  void increasedSpeed() {
    final speed = state.speed + 5;
    final newState = state.copy(speed: speed);
    state = newState;
  }

  void hitBrake() {
    final speed = max(0, state.speed - 30);
    final newState = state.copy(speed: speed);
    state = newState;
  }
}

final stateProvider =
    StateNotifierProvider<CarNotifier, Car>((ref) => CarNotifier());

class TutStateNotifierProvider extends ConsumerWidget {
  const TutStateNotifierProvider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateNotifier = ref.watch(stateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('State Notifier Provider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Speed: ${stateNotifier.speed.toString()}",
                style: Theme.of(context).textTheme.displayMedium),
            Text("Doors: ${stateNotifier.doors.toString()}",
                style: Theme.of(context).textTheme.displayMedium),
            _adjustSpeed(ref),
            Slider(
              value: stateNotifier.doors.toDouble(),
              max: 5,
              onChanged: (value) {
                ref.read(stateProvider.notifier).setDoors(value.toInt());
              },
            ),
          ],
        ),
      ),
    );
  }

  Row _adjustSpeed(WidgetRef ref) {
    final stateNotifierFunc = ref.read(stateProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            onPressed: () {
              stateNotifierFunc.increasedSpeed();
            },
            child: const Text('Increase +5')),
        ElevatedButton(
            onPressed: () {
              stateNotifierFunc.hitBrake();
            },
            child: const Text('Hit Brake -30')),
      ],
    );
  }
}
