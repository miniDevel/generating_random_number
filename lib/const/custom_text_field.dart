import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool isNumbers;
  final ValueChanged<String>? onChanged;
  final String? initialValue;
  final String hintText;
  final double boxWidth;

  const CustomTextField({
    this.controller,
    required this.isNumbers,
    required this.onChanged,
    required this.boxWidth,
    required this.hintText,
    required this.initialValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: boxWidth,
      height: 40,
      child: renderTextField(),
    );
  }

  Widget renderTextField() {
    const TextStyle customTextStyle =
        TextStyle(fontWeight: FontWeight.w600, fontSize: 24);

    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      style: customTextStyle.copyWith(color: Colors.black87),
      cursorColor: Colors.black87,
      maxLines: 1,
      textAlign: TextAlign.center,
      initialValue: initialValue,
      keyboardType: isNumbers ? TextInputType.number : TextInputType.text,
      inputFormatters:
          isNumbers ? [FilteringTextInputFormatter.digitsOnly] : null,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 8),
          hintText: hintText,
          hintStyle: customTextStyle.copyWith(color: Colors.grey),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black87,
              width: 2,
            ),
          )),
    );
  }
}
