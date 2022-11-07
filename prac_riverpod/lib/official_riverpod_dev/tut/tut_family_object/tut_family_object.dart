// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:prac_riverpod/official_riverpod_dev/tut/tut_family_primitive/user_helper.dart';
import 'package:prac_riverpod/official_riverpod_dev/tut/tut_family_primitive/user_widget.dart';

class UserRequest extends Equatable {
  final bool isFemale;
  final int minAge;

  const UserRequest({required this.isFemale, required this.minAge});

  @override
  List<Object> get props => [isFemale, minAge];
}

Future<User> fetchUser(UserRequest request) async {
  await Future.delayed(const Duration(milliseconds: 400));
  final gender = request.isFemale ? 'female' : 'male';

  return users.firstWhere(
      (user) => user.gender == gender && user.age >= request.minAge);
}

final userProvider = FutureProvider.family<User, UserRequest>(
  (ref, userRequest) async => fetchUser(userRequest),
);

class FamilyObjectModifierPage extends StatefulWidget {
  const FamilyObjectModifierPage({super.key});

  @override
  _FamilyObjectModifierPageState createState() =>
      _FamilyObjectModifierPageState();
}

class _FamilyObjectModifierPageState extends State<FamilyObjectModifierPage> {
  static final ages = [18, 25, 30, 40];
  bool isFemale = true;
  int minAge = ages.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FamilyObject Modifier'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: Consumer(builder: (context, ref, child) {
                final userRequest =
                    UserRequest(isFemale: isFemale, minAge: minAge);
                final future = ref.watch(userProvider(userRequest));

                return future.when(
                  data: (user) => UserWidget(user: user),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, stack) => const Center(child: Text('Not found')),
                );
              }),
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
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Search',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            buildGenderSwitch(),
            const SizedBox(height: 16),
            buildAgeDropdown(),
          ],
        ),
      );

  Widget buildGenderSwitch() => Row(
        children: [
          Text(
            'Female',
            style: TextStyle(fontSize: 24),
          ),
          Spacer(),
          CupertinoSwitch(
            value: isFemale,
            onChanged: (value) => setState(() => isFemale = value),
          ),
        ],
      );

  Widget buildAgeDropdown() => Row(
        children: [
          Text(
            'Age',
            style: TextStyle(fontSize: 24),
          ),
          Spacer(),
          DropdownButton<int>(
            value: minAge,
            iconSize: 32,
            style: TextStyle(fontSize: 24, color: Colors.black),
            onChanged: (value) => setState(() => minAge = value!),
            items: ages
                .map<DropdownMenuItem<int>>(
                    (int value) => DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value years old'),
                        ))
                .toList(),
          ),
        ],
      );
}
