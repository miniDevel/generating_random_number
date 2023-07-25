import 'package:flutter/material.dart';
import 'package:generating_random_number/const/middle_button.dart';

class TopListGenerator extends StatelessWidget {
  final Widget listGenerator;
  final VoidCallback onModeChangeButtonPressed;
  final VoidCallback onGenerateButtonPressed;
  const TopListGenerator({
    required this.listGenerator,
    required this.onModeChangeButtonPressed,
    required this.onGenerateButtonPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SingleChildScrollView(
            child: listGenerator,
          ),
          SizedBox(height: 20),
          MiddleButton(
              onModeChangeButtonPressed: onModeChangeButtonPressed,
              onGenerateButtonPressed: onGenerateButtonPressed),
        ],
      ),
    );
  }
}
