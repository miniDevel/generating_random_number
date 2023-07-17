import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String? initialValue;
  final String hintText;
  final double boxWidth;

  const CustomTextField({
    required this.boxWidth,
    required this.hintText,
    required this.initialValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.boxWidth,
      height: 40,
      child: renderTextField(),
    );
  }

  Widget renderTextField() {
    return TextFormField(
      cursorColor: Colors.black87,
      maxLines: 1,
      initialValue: initialValue,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        hintText: hintText,
      ),

    );
  }
}
