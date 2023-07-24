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
    final TextStyle customButtonTextStyle =
    TextStyle(fontWeight: FontWeight.w600, fontSize: 20);

    return Column(
      children: [
        CustomButton(
          child: Text(
            "생성 하기",
            style: customButtonTextStyle,
          ),
          onPressed: onGenerateButtonPressed,
        ),
        SizedBox(
          height: 10,
        ),
        CustomButton(
          child: Text(
            "모드 변경",
            style: customButtonTextStyle,
          ),
          onPressed: onModeChangeButtonPressed,
        ),
      ],
    );
  }
}