import 'package:flutter/material.dart';
import 'package:generating_random_number/const/custom_button.dart';

class ChooseButton extends StatelessWidget {
  final String topLabel;
  final String bottomLabel;
  final VoidCallback onTopPressed;
  final VoidCallback onBottomPressed;

  const ChooseButton({
    required this.onBottomPressed,
    required this.bottomLabel,
    required this.onTopPressed,
    required this.topLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            ModeSelectButton(
              onPressed: onTopPressed,
              label: topLabel,
            ),
            const SizedBox(height: 20),
            ModeSelectButton(
              onPressed: onBottomPressed,
              label: bottomLabel,
            ),
          ],
        ),
      ],
    );
  }
}

class ModeSelectButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const ModeSelectButton({
    required this.onPressed,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const TextStyle customTextStyle =
        TextStyle(fontWeight: FontWeight.w600, fontSize: 20);

    return CustomButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: customTextStyle,
      ),
    );
  }
}
