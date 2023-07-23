import 'package:flutter/material.dart';
import 'package:generating_random_number/const/custom_button.dart';

class ChooseButton extends StatelessWidget {
  final String topLabel;
  final String bottomLabel;
  final VoidCallback onTopPressed;
  final VoidCallback onBottomPressed;
  final double bottomSpaceHeight;
  final double topSpaceHeight;
  const ChooseButton({
    required this.onBottomPressed,
    required this.bottomLabel,
    required this.onTopPressed,
    required this.topLabel,
    required this.bottomSpaceHeight,
    required this.topSpaceHeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: topSpaceHeight,
        ),
        Column(
          children: [
            CustomButton(
              child: Text(topLabel),
              onPressed: onTopPressed,
            ),
            CustomButton(
              child: Text(bottomLabel),
              onPressed: onBottomPressed,
            ),
          ],
        ),
        SizedBox(
          height: bottomSpaceHeight,
        )
      ],
    );
  }
}
