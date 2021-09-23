import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final VoidCallback onPress;
  final IconData icon;
  final String text;
  final int style;

  const SettingItem({
    this.style = 1,
    required this.text,
    required this.icon,
    required this.onPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      tileColor: Colors.white,
      title: Text(text),
      trailing: Icon(
        icon,
        color: Colors.grey,
        size: 20,
      ),
    );
  }
}
