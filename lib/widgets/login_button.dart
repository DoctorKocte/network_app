import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
      super.key,
      required this.buttonText,
      this.isOutlined = false,
      required this.onPressed
    });

  final String buttonText;
  final bool isOutlined;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return 
     GestureDetector(
      onTap: () { onPressed(); },
      child: Material(
        borderRadius: BorderRadius.circular(30),
        //elevation: 4,
        child: Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 43, 97, 142),
            border: Border.all(color: const Color.fromARGB(255, 30, 76, 116), width: 3),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              buttonText, 
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}