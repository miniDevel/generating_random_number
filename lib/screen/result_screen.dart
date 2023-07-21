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
  bool isLoading = true;
  late int maximumNumber;
  late int minimumNumber;
  List<int> randomNumbers = [];
  final List<String> loadingTexts = [
    "음...",
    "뭐가 좋을까..",
    "온다..!!",
    "이번엔~~",
    "그 숫자는..",
  ];
  String? loadingText;

  @override
  void initState() {
    super.initState();
    loadingText = loadingTexts[Random().nextInt(loadingTexts.length)];

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });

    maximumNumber = int.parse(widget.maximumNumber);
    minimumNumber = int.parse(widget.minimumNumber);

    if (widget.isDuplicate) {
      for (int i = 0; i < widget.generationCount; i++) {
        int randomNumber =
            Random().nextInt(maximumNumber - minimumNumber + 1) + minimumNumber;
        randomNumbers.add(randomNumber);
      }
    } else {
      while (randomNumbers.length < widget.generationCount) {
        int randomNumber =
            Random().nextInt(maximumNumber - minimumNumber + 1) + minimumNumber;
        if (!randomNumbers.contains(randomNumber)) {
          randomNumbers.add(randomNumber);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle customTextStyle =
        TextStyle(fontWeight: FontWeight.w600, fontSize: 50);

    return SafeArea(
      child: Scaffold(
        backgroundColor: WHITE_COLOR,
        body: Column(
          children: [
            _ResultBox(
              children: isLoading
                  ? [
                      Text(
                        ". . .",
                        style: customTextStyle,
                      )
                    ]
                  : randomNumbers
                      .map(
                        (e) => Text(
                          e.toString(),
                          style: customTextStyle,
                        ),
                      )
                      .toList(),
            ),
            isLoading
                ? SizedBox(height: 48)
                : _Buttons(
                    onRangePressed: onRangePressed,
                  ),
            _BottomResultPicture(
              picture: isLoading
                  ? Image.asset('assets/img/loading.png')
                  : Image.asset('assets/img/result.png'),
              text: isLoading ? loadingText! : "바로 이 숫자야!",
            ),
          ],
        ),
      ),
    );
  }

  void onRangePressed() {
    setState(() {
      randomNumbers.sort();
    });
  }
}

class _Buttons extends StatelessWidget {
  final VoidCallback onRangePressed;

  const _Buttons({
    required this.onRangePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width / 4;
    TextStyle customTextStyle =
        TextStyle(fontWeight: FontWeight.w600, fontSize: 20);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomButton(
            child: Container(
              width: buttonWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "정리하기 ",
                    style: customTextStyle,
                  ),
                  Icon(Icons.date_range),
                ],
              ),
            ),
            onPressed: onRangePressed,
          ),
          CustomButton(
            child: Container(
              width: buttonWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "다시하기 ",
                    style: customTextStyle,
                  ),
                  Icon(Icons.refresh),
                ],
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
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
                    spacing: 40,
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
  final Widget picture;
  final String text;

  const _BottomResultPicture({
    required this.picture,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        picture,
        Positioned(
          top: 20,
          right: 4,
          child: Image.asset(
            'assets/img/speech_bubble.png',
            height: 100,
          ),
        ),
        Positioned(
          top: 50,
          right: 14,
          child: Container(
            width: 138,
            child: Center(
              child: Text(
                text,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        )
      ],
    );
  }
}
