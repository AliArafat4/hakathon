import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.content,
    required this.onPressedFunc,
  });
  final String content;
  final Function()? onPressedFunc;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black12,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
          onPressed: onPressedFunc,
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
