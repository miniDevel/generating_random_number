import 'dart:math';
import 'package:flutter/material.dart';
import 'package:generating_random_number/component/custom_button.dart';
import 'package:generating_random_number/const/colors.dart';

class ResultScreen extends StatefulWidget {
  final String maximumNumber;
  final String minimumNumber;
  final int generationCount;
  final bool isDuplicate;
  const ResultScreen({
    required this.maximumNumber,
    required this.minimumNumber,
    required this.generationCount,
    required this.isDuplicate,
    super.key,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late int maximumNumber;
  late int minimumNumber;
  List<int> randomNumbers = [];

  @override
  void initState() {
    super.initState();
    maximumNumber = int.parse(widget.maximumNumber);
    minimumNumber = int.parse(widget.minimumNumber);

    if (widget.isDuplicate) {
      for (int i = 0; i < widget.generationCount; i++) {
        int randomNumber = Random().nextInt(maximumNumber) + minimumNumber;
        randomNumbers.add(randomNumber);
      }
    } else {
      while (randomNumbers.length < widget.generationCount) {
        int randomNumber = Random().nextInt(maximumNumber) + minimumNumber;
        if (!randomNumbers.contains(randomNumber)) {
          randomNumbers.add(randomNumber);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: WHITE_COLOR,
        body: Column(
          children: [
            _ResultBox(
              children: randomNumbers
                  .map(
                    (e) => Text(
                      ' $e ',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 50),
                    ),
                  )
                  .toList(),
            ),
            _ReStartButton(),
            _BottomResultPicture(),
          ],
        ),
      ),
    );
  }
}

class _ReStartButton extends StatelessWidget {
  const _ReStartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      child: Container(
        width: 104,
        child: Row(
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

class _ResultBox extends StatelessWidget {
  final List<Text> children;

  const _ResultBox({
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 20.0,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Center(
                  child: Wrap(
                    children: children,
                  ),
                ),
              ),
            ),
          ),
          decoration: BoxDecoration(
              color: WHITE_COLOR,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10.0,
                  spreadRadius: 0.5,
                  offset: Offset(0, 6),
                )
              ]),
        ),
      ),
    );
  }
}

class _BottomResultPicture extends StatelessWidget {
  const _BottomResultPicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/img/result.png'),
        Positioned(
          top: 20,
          right: 4,
          child: Image.asset(
            'assets/img/speech_bubble.png',
            height: 100,
          ),
        ),
        Positioned(
          top: 48,
          right: 14,
          child: Text(
            '바로 이 숫자야!',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
