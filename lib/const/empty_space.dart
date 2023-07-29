import 'package:flutter/material.dart';

Widget emptySpace(int flex) {
  return Expanded(
    flex: flex,
    child: Container(
        child: SizedBox(
          width: 50,
        )),
  );
}