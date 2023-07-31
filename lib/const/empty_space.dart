import 'package:flutter/material.dart';

Widget emptySpace(int flex) {
  return Expanded(
    flex: flex,
    child: const SizedBox(
      width: 50,
    ),
  );
}