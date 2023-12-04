// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class textButtonwithicon extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color colorblack;
  final void Function() pressed;

  const textButtonwithicon({
    super.key,
    required this.colorblack,
    required this.icon,
    required this.text,
    required this.pressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: pressed,
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(70.0, 5))),
      icon: Icon(
        icon,
        color: colorblack,
      ),
      label: Text(
        text,
        style: TextStyle(color: colorblack),
      ),
    );
  }
}

class iconButton extends StatelessWidget {
  final IconData icon;
  final Color colorwhite;
  final Color backgroundcolor;
  const iconButton(
      {super.key,
      required this.backgroundcolor,
      required this.colorwhite,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: () {},
      iconSize: 20,
      icon: Icon(
        icon,
        color: colorwhite,
      ),
      style: IconButton.styleFrom(backgroundColor: backgroundcolor),
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final void Function() onpressed;
  const Button({super.key, required this.text, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(.0),
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
