import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const CustomButton({
    required this.child,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey,
      ),
    );
  }
}
