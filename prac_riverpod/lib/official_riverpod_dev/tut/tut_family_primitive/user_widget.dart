import 'package:flutter/material.dart';
import 'package:prac_riverpod/official_riverpod_dev/tut/tut_family_primitive/user_helper.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.black12,
          backgroundImage: NetworkImage(user.urlAvatar),
          radius: 80,
        ),
        const SizedBox(height: 24),
        buildHeader('Name: ', user.name),
        const SizedBox(height: 8),
        buildHeader('Name: ', user.age.toString()),
        const SizedBox(height: 8),
        buildHeader('Name: ', user.gender)
      ],
    );
  }

  Widget buildHeader(String header, String value) => Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            SizedBox(
              width: 120,
              child: Text(
                header,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 120,
              child: Text(
                value,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const Spacer(),
          ],
        ),
      );
}
