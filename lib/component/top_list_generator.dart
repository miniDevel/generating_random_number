import 'package:flutter/material.dart';

class TopListGenerator extends StatelessWidget {
  final Widget listGenerator;

  const TopListGenerator({
    required this.listGenerator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        listGenerator,
        SizedBox(height: 20),
      ],
    );
  }
}
