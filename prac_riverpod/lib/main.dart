import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prac_riverpod/official_riverpod_dev/example1_counter/example1_counter.dart';
import 'package:prac_riverpod/official_riverpod_dev/example2_timer/example2_timer.dart';
import 'package:prac_riverpod/official_riverpod_dev/tut/tut_combine_providers.dart';
import 'package:prac_riverpod/official_riverpod_dev/tut/tut_family_object/tut_family_object.dart';
import 'package:prac_riverpod/official_riverpod_dev/tut/tut_family_primitive/tut_family_primitive.dart';
import 'package:prac_riverpod/official_riverpod_dev/tut/tut_future_provider.dart';
import 'package:prac_riverpod/official_riverpod_dev/tut/tut_provider.dart';
import 'package:prac_riverpod/official_riverpod_dev/tut/tut_state_notifier_provider.dart';
import 'package:prac_riverpod/official_riverpod_dev/tut/tut_stream_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}
// Provider가 동작하기 위해서 Flutter 앱의 가장 최상위 부모 위젯을
// 'ProviderScope' 로 감싸주어야 함

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Tutorial'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TutProvider()));
              },
              child: const Text('Tutorial : Provider'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TutFutureProvider()));
              },
              child: const Text('Tutorial : TutFutureProvider'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TutStreamProvider()));
              },
              child: const Text('Tutorial : TutStreamProvider'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TutCombineProviders()));
              },
              child: const Text('Tutorial : TutCombineProviders'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TutStateNotifierProvider()));
              },
              child: const Text('Tutorial : TutStateNotifierProvider'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TutFamilyPrimitive()));
              },
              child: const Text('Tutorial : TutFamily Primitive'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FamilyObjectModifierPage()));
              },
              child: const Text('Tutorial : TutFamily Object'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Example1Counter()));
              },
              child: const Text('Go to Counter Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Example2Timer()));
              },
              child: const Text('Go to Timer Page'),
            ),
          ],
        ),
      ),
    );
  }
}


/*
  ? 프로바이더 : 상태의 변화를 감시하는 역할을 하는 압축된 객체

  ? 프로바이더는 보편적으로 전역 변수로 선언하여 사용한다
   <- 프로바이더는 완전히 불변하는 (immutable) 특성을 가진다
    즉, 어디에서나 사용하고 어디에선 상태에 도달할 수 있지만 전역적이지 않다.

  ? 프로바이더 수식자 (Provider Modifiers)
   - .autoDispose : 더 이상 상태를 구독하지 않을 때 자동으로 프로바이더를 소멸하도록 함
    -> 메모리 낭비를 막을 수 있다
   - .family : 외부 파라미터로부터 프로바이더를 생성할 때 사용

   ? "ref" Object
    : 'ref'는 프로바이더 사이의 상호작용을 도와주고 
    위젯이나 다른 프로바이더에서 사용될 수 있도록 함.
    
  ? ref를 사용하여 프로바이더와 상호직용
    ! ref.watch
     : 프로바이더의 값을 취득하고 변화를 구독함.
     값의 변경이 발생하면, 위젯을 다시 빌드하거나
     값을 구독하고 있는 위치에 상태 값을 전달 및 제공함
    ! ref.listen
     : 프로바이더의 상태 값을 구독하거나 상태값이 변했을 때,
     어떤 행위를 취해야할 경우 사용한다.
    ! ref.read
     : 프로바이더의 상태값을 취득.
     이벤트 콜백함수에서 사용하기 유용하다.

     watch method는 비동기처리(asynchronously)에 호출하지 않는 것이 좋다.
     예를 들어 ElevatedButton의 onPressed 콜백 함수 안이나 initState 그리고 
     다른 State의 생명주기 안에서는 watch메소드를 호출하면 안된다.
     이때는 ref.watch대신 ref.read메소드를 사용하는 것이 권장된다.
     listen메소드 또한 비동기(asynchronously)로 호출 가능한 곳에서는 사용을 피해야함.

     ! ref.watch는 프로바이더 상태값이 변경이되면 widget/provider을 다시 빌드하지만 ref.listen은 함수를 호출한다는 점
 */