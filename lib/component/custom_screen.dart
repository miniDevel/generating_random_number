import 'package:flutter/material.dart';


class CustomScreenContainer extends StatelessWidget {
  final List<Widget> children;
  const CustomScreenContainer({required this.children, super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:children,
      ),
    );
  }
}
