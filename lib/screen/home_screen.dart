import 'package:flutter/material.dart';
import 'package:generating_random_number/component/choose_butteon.dart';
import 'package:generating_random_number/component/top_number_texture.dart';
import 'package:generating_random_number/const/colors.dart';
import 'package:generating_random_number/screen/result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final topTextureKey = GlobalKey();
  final middleButtonKey = GlobalKey();
  final stackKey = GlobalKey();
  String currentText = '어떤걸 도와줄까?';
  String? maximumNumber;
  String? minimumNumber;
  int? generationCount;
  bool isDuplicate = false;
  bool? isGeneratingNumbers;

  @override
  Widget build(BuildContext context) {
    final emptySpaceHeight = ((MediaQuery.of(context).size.height -
            70 -
            getTopTextureHeight() -
            getMiddleButtonHeight() -
            getStackHeight())) /
        3;

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: WHITE_COLOR,
          body: SingleChildScrollView(
            child: Column(
              children: [
                isGeneratingNumbers == null
                    ? ChooseButton(
                        onTopPressed: () {
                          setState(() {
                            currentText = '위에 입력하면 내가 숫자를 말해줄게!';
                            isGeneratingNumbers = true;
                          });
                        },
                        topLabel: "랜덤숫자생성",
                        onBottomPressed: () {
                          currentText = '리스트를 작성하면 내가 골라줄게!';
                          isGeneratingNumbers = false;
                        },
                        bottomLabel: "리스트만들기",
                        topSpaceHeight: emptySpaceHeight,
                        bottomSpaceHeight: emptySpaceHeight * 2,
                      )
                    : SizedBox(),
                isGeneratingNumbers == null
                    ? SizedBox()
                    : !isGeneratingNumbers!
                        ? TopNumberTexture(
                            isDuplicate: isDuplicate,
                            onDuplicationBoxTap: onDuplicationBoxTap,
                            onButtonPressed: onNumberGenerationButtonPressed,
                            onMaximumNumberChanged: onMaximumNumberChanged,
                            onCountChanged: onCountChanged,
                            onMinimumNumberChanged: onMinimumNumberChanged,
                            emptySpaceHeight: emptySpaceHeight,
                            topTextureKey: topTextureKey,
                            middleButtonKey: middleButtonKey,
                          )
                        : TopNumberTexture(
                            isDuplicate: isDuplicate,
                            onDuplicationBoxTap: onDuplicationBoxTap,
                            onButtonPressed: onNumberGenerationButtonPressed,
                            onMaximumNumberChanged: onMaximumNumberChanged,
                            onCountChanged: onCountChanged,
                            onMinimumNumberChanged: onMinimumNumberChanged,
                            emptySpaceHeight: emptySpaceHeight,
                            middleButtonKey: middleButtonKey,
                            topTextureKey: topTextureKey),
                _BottomPicture(stackKey: stackKey, text: currentText),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onDuplicationBoxTap() {
    setState(() {
      isDuplicate = !isDuplicate;
    });
  }

  onNumberGenerationButtonPressed() {
    if (minimumNumber == null ||
        maximumNumber == null ||
        generationCount == null) {
      setState(() {
        currentText = '빈 칸을 전부 입력 해줘~';
      });
    } else {
      int min = int.parse(minimumNumber!);
      int max = int.parse(maximumNumber!);

      if (min > max || max - min <= 0) {
        setState(() {
          currentText = '숫자가 이상해~';
        });
      } else {
        if (generationCount! <= 0) {
          setState(() {
            currentText = '0개는 만들수 없어 ㅠ';
          });
        } else {
          if (max - min < generationCount! - 1) {
            setState(() {
              currentText = '너무 많이 만드는거 같아!';
            });
          } else {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (_) => ResultScreen(
                    maximumNumber: maximumNumber!,
                    minimumNumber: minimumNumber!,
                    generationCount: generationCount!,
                    isDuplicate: isDuplicate),
              ),
            )
                .then((value) {
              if (value != null) {
                setState(() {
                  currentText = value;
                });
              }
            });
          }
        }
      }
    }
    FocusScope.of(context).requestFocus(FocusNode());
  }

  onMinimumNumberChanged(String? val) {
    if (val!.isEmpty) {
      minimumNumber = null;
    } else {
      minimumNumber = val;
    }
  }

  onCountChanged(String? val) {
    if (val!.isEmpty) {
      generationCount = null;
    } else {
      generationCount = int.parse(val);
    }
  }

  onMaximumNumberChanged(String? val) {
    if (val!.isEmpty) {
      maximumNumber = null;
    } else {
      maximumNumber = val;
    }
  }

  double getTopTextureHeight() {
    final RenderBox? renderBox =
        topTextureKey.currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.size.height ?? 0.0;
  }

  double getMiddleButtonHeight() {
    final RenderBox? renderBox =
        middleButtonKey.currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.size.height ?? 0.0;
  }

  double getStackHeight() {
    final RenderBox? renderBox =
        stackKey.currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.size.height ?? 0.0;
  }
}

class _BottomPicture extends StatelessWidget {
  final GlobalKey stackKey;
  final String text;

  const _BottomPicture({
    required this.stackKey,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: stackKey,
      children: [
        Image.asset('assets/img/home_screen.png'),
        Positioned(
          top: 52,
          right: 42,
          child: Container(
            width: 330,
            child: Center(
              child: Text(
                text,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
