import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac_riverpod/official_riverpod_dev/tut/tut_family_primitive/user_helper.dart';
import 'package:prac_riverpod/official_riverpod_dev/tut/tut_family_primitive/user_widget.dart';

Future<User> fetchUser(String username) async {
  await Future.delayed(const Duration(microseconds: 400));

  return users.firstWhere((user) => user.name == username);
}

final userProvider = FutureProvider.family<User, String>(
    (ref, username) async => fetchUser(username));

class TutFamilyPrimitive extends StatefulWidget {
  const TutFamilyPrimitive({super.key});

  @override
  State<TutFamilyPrimitive> createState() => _TutFamilyPrimitiveState();
}

class _TutFamilyPrimitiveState extends State<TutFamilyPrimitive> {
  String username = users.first.name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Primitive Modifier'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              child: Consumer(
                builder: (context, ref, child) {
                  final future = ref.watch(userProvider(username));

                  return future.when(
                      data: (data) => UserWidget(user: data),
                      error: (error, stackTrace) =>
                          Center(child: Text(error.toString())),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()));
                },
              ),
            ),
            const SizedBox(height: 32),
            buildSearch(),
          ],
        ),
      ),
    );
  }

  Widget buildSearch() => Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Search',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            buildUsernameDropdown(),
          ],
        ),
      );

  Widget buildUsernameDropdown() => Row(
        children: [
          Text(
            'Username',
            style: TextStyle(fontSize: 24),
          ),
          Spacer(),
          DropdownButton<String>(
            value: username,
            iconSize: 32,
            style: TextStyle(fontSize: 24, color: Colors.black),
            onChanged: (value) => setState(() => username = value!),
            items: users
                .map((user) => user.name)
                .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                .toList(),
          ),
        ],
      );
}
