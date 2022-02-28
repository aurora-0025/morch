import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function() onPress;
  final bool isButtonDisabled;

  const MyButton(
      {Key? key, required this.isButtonDisabled, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Image.asset(
          'lib/icons/play.png',
          height: 20,
          color: const Color.fromARGB(255, 54, 54, 54),
        ),
        onPressed: isButtonDisabled ? null : onPress,
        style: ButtonStyle(
          backgroundColor: isButtonDisabled
              ? MaterialStateProperty.all(
                  const Color.fromARGB(255, 185, 185, 185))
              : MaterialStateProperty.all(
                  const Color.fromARGB(255, 224, 224, 224)),
          padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
        ));
  }
}
