import 'package:flutter/material.dart';
import 'package:generating_random_number/const/custom_button.dart';

class MiddleButton extends StatelessWidget {
  final VoidCallback onGenerateButtonPressed;
  final VoidCallback onModeChangeButtonPressed;
  const MiddleButton({
    required this.onModeChangeButtonPressed,
    required this.onGenerateButtonPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const TextStyle customButtonTextStyle =
        TextStyle(fontWeight: FontWeight.w600, fontSize: 20);

    return Column(
      children: [
        CustomButton(
          onPressed: onGenerateButtonPressed,
          child: const Text(
            "생성 하기",
            style: customButtonTextStyle,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomButton(
          onPressed: onModeChangeButtonPressed,
          child: const Text(
            "모드 변경",
            style: customButtonTextStyle,
          ),
        ),
      ],
    );
  }
}
