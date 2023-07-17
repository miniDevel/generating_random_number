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
    TextStyle customTextStyle =
        TextStyle(fontWeight: FontWeight.w600, fontSize: 24);

    return TextFormField(
      style: customTextStyle.copyWith(color: Colors.black87),
      cursorColor: Colors.black87,
      maxLines: 1,
      textAlign: TextAlign.center,
      initialValue: initialValue,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 8),
          hintText: hintText,
          hintStyle: customTextStyle.copyWith(color: Colors.grey),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black87,
              width: 2,
            ),
          )),
    );
  }
}
