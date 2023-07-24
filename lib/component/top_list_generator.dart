import 'package:flutter/material.dart';
import 'package:generating_random_number/const/middle_button.dart';

class TopListGenerator extends StatelessWidget {
  final VoidCallback onModeChangeButtonPressed;
  final VoidCallback onGenerateButtonPressed;
  const TopListGenerator({
    required this.onModeChangeButtonPressed,
    required this.onGenerateButtonPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle customButtonTextStyle =
        TextStyle(fontWeight: FontWeight.w600, fontSize: 20);

    return MiddleButton(
        onModeChangeButtonPressed: onModeChangeButtonPressed,
        onGenerateButtonPressed: onGenerateButtonPressed);
  }
}
