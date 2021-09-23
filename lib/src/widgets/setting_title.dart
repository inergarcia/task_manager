import 'package:flutter/material.dart';

class SettingTitle extends StatelessWidget {
  final String text;
  final List<Widget> items;
  const SettingTitle({
    required this.text,
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
          width: double.infinity,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
        ...items
      ],
    );
  }
}
