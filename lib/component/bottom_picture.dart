import 'package:flutter/material.dart';

class BottomPicture extends StatelessWidget {
  final Widget child;
  const BottomPicture({required this.child,super.key,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SizedBox(),
        ),
        child,
        SizedBox(height: 20)
      ],
    );
  }
}
