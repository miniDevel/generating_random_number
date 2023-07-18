import 'package:flutter/material.dart';
import 'package:generating_random_number/component/bottom_picture.dart';
import 'package:generating_random_number/component/custom_button.dart';
import 'package:generating_random_number/component/custom_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScreenContainer(
          children: [
            ReStartButton(),
            BottomPicture(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}

class ReStartButton extends StatelessWidget {
  const ReStartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      child: Container(
        width: 104,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "다시하기 ",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            Icon(Icons.refresh),
          ],
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
