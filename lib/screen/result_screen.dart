import 'package:flutter/material.dart';

import 'package:generating_random_number/component/custom_button.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.grey,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              ReStartButton(),
              Stack(
                children: [
                  Image.asset('assets/img/result.png'),
                  Image.asset('assets/img/speech_bubble.png',height: 100,)
                ],
              ),
            ],
          ),
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
