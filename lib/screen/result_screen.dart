import 'dart:math';
import 'package:flutter/material.dart';
import 'package:generating_random_number/const/colors.dart';
import 'package:generating_random_number/const/custom_button.dart';

class ResultScreen extends StatefulWidget {
  final List<String>? listItems;
  final bool isNumberGenerating;
  final String? maximumNumber;
  final String? minimumNumber;
  final int generationCount;
  final bool? isDuplicate;

  const ResultScreen({
    this.listItems,
    required this.isNumberGenerating,
    this.maximumNumber,
    this.minimumNumber,
    required this.generationCount,
    this.isDuplicate,
    super.key,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<String> selectListItems = [];
  bool isLoading = true;
  late int maximumNumber;
  late int minimumNumber;
  List<int> randomNumbers = [];
  final List<String> loadingTexts = [
    "음...",
    "뭐가 좋을까..",
    "온다..!!",
    "이번엔~~",
    "내가 고른거는..",
  ];
  String? loadingText;

  @override
  void initState() {
    super.initState();
    loadingText = loadingTexts[Random().nextInt(loadingTexts.length)];

    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        isLoading = false;
      });
    });

    if (widget.isNumberGenerating) {
      maximumNumber = int.parse(widget.maximumNumber!);
      minimumNumber = int.parse(widget.minimumNumber!);

      if (widget.isDuplicate!) {
        for (int i = 0; i < widget.generationCount; i++) {
          int randomNumber =
              Random().nextInt(maximumNumber - minimumNumber + 1) +
                  minimumNumber;
          randomNumbers.add(randomNumber);
        }
      } else {
        while (randomNumbers.length < widget.generationCount) {
          int randomNumber =
              Random().nextInt(maximumNumber - minimumNumber + 1) +
                  minimumNumber;
          if (!randomNumbers.contains(randomNumber)) {
            randomNumbers.add(randomNumber);
          }
        }
      }
    } else {
      while (selectListItems.length < widget.generationCount) {
        int selectListItemIndex = Random().nextInt(widget.listItems!.length);
        if (!selectListItems.contains(widget.listItems![selectListItemIndex])) {
          selectListItems.add(widget.listItems![selectListItemIndex]);
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
              children: isLoading
                  ? [". . ."]
                  : widget.isNumberGenerating
                      ? randomNumbers
                      : selectListItems,
            ),
            isLoading
                ? const SizedBox(height: 48)
                : Buttons(
                    onRangePressed: onRangePressed,
                    isNumbers: widget.isNumberGenerating ? true : false,
                  ),
            _BottomResultPicture(
              picture: isLoading
                  ? Image.asset('assets/img/loading.png')
                  : Image.asset('assets/img/result.png'),
              text: isLoading
                  ? loadingText!
                  : widget.isNumberGenerating
                      ? "바로 이 숫자야!"
                      : "바로 이거야!",
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

class _ResultBox extends StatelessWidget {
  final List children;

  const _ResultBox({
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    const TextStyle customTextStyle =
        TextStyle(fontWeight: FontWeight.w600, fontSize: 50);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 20.0,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: WHITE_COLOR,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10.0,
                  spreadRadius: 0.5,
                  offset: Offset(0, 6),
                )
              ]),
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
                    children: children
                        .map(
                          (e) => Text(
                            e.toString(),
                            style: customTextStyle,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
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
          child: SizedBox(
            width: 138,
            child: Center(
              child: Text(
                text,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class Buttons extends StatelessWidget {
  final bool isNumbers;
  final VoidCallback onRangePressed;

  const Buttons({
    required this.isNumbers,
    required this.onRangePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width / 4;
    const TextStyle customTextStyle =
        TextStyle(fontWeight: FontWeight.w600, fontSize: 20);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          isNumbers
              ? CustomButton(
                  onPressed: onRangePressed,
                  child: SizedBox(
                    width: buttonWidth,
                    child: const Row(
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
                )
              : const SizedBox(),
          CustomButton(
            child: SizedBox(
              width: buttonWidth,
              child: const Row(
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
              Navigator.of(context).pop('다시 해볼까?');
            },
          ),
        ],
      ),
    );
  }
}
