import 'package:flutter/material.dart';
import 'package:generating_random_number/component/choose_butteon.dart';
import 'package:generating_random_number/component/top_list_generator.dart';
import 'package:generating_random_number/component/top_number_generator.dart';
import 'package:generating_random_number/const/colors.dart';
import 'package:generating_random_number/const/custom_button.dart';
import 'package:generating_random_number/const/custom_text_field.dart';
import 'package:generating_random_number/const/middle_button.dart';
import 'package:generating_random_number/screen/result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentText = '어떤걸 도와줄까?';
  String? maximumNumber;
  String? minimumNumber;
  int? generationCount;
  bool isDuplicate = false;
  bool? isGeneratingNumbers;
  final String selectedLabelText = '리스트를 작성하면 내가 골라줄게!';
  final String selectedNumberText = "위에 입력하면 내가 숫자를 말해줄게!";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: WHITE_COLOR,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                isGeneratingNumbers == null || isGeneratingNumbers!
                    ? EmptySpace(3)
                    : SizedBox(),
                isGeneratingNumbers == null
                    ? ChooseButton(
                        onTopPressed: onTopPressed,
                        topLabel: "랜덤숫자생성",
                        onBottomPressed: onBottomPressed,
                        bottomLabel: "리스트만들기",
                      )
                    : SizedBox(),
                isGeneratingNumbers == null
                    ? SizedBox()
                    : !isGeneratingNumbers!
                        ? Expanded(
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Label(),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.add),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : TopNumberGenerator(
                            isDuplicate: isDuplicate,
                            onDuplicationBoxTap: onDuplicationBoxTap,
                            onMaximumNumberChanged: onMaximumNumberChanged,
                            onCountChanged: onCountChanged,
                            onMinimumNumberChanged: onMinimumNumberChanged,
                          ),
                isGeneratingNumbers != null
                    ? MiddleButton(
                        onGenerateButtonPressed: isGeneratingNumbers!
                            ? onNumberGenerateButtonPressed
                            : onListGenerateButtonPressed,
                        onModeChangeButtonPressed: onModeChangeButtonPressed,
                      )
                    : SizedBox(),
                isGeneratingNumbers == null || isGeneratingNumbers!
                    ? EmptySpace(2)
                    : SizedBox(),
                Container(child: _BottomPicture(text: currentText)),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onTopPressed() {
    setState(() {
      currentText = selectedNumberText;
      isGeneratingNumbers = true;
    });
  }

  onBottomPressed() {
    setState(() {
      currentText = selectedLabelText;
      isGeneratingNumbers = false;
    });
  }

  onDuplicationBoxTap() {
    setState(() {
      isDuplicate = !isDuplicate;
    });
  }

  onListGenerateButtonPressed() {}

  onModeChangeButtonPressed() {
    setState(() {
      isGeneratingNumbers = !isGeneratingNumbers!;
      if (isGeneratingNumbers!) {
        currentText = selectedNumberText;
      } else {
        currentText = selectedLabelText;
      }
      maximumNumber = null;
      minimumNumber = null;
      generationCount = null;
    });
  }

  onNumberGenerateButtonPressed() {
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
}

Widget EmptySpace(int flex) {
  return Expanded(
    flex: flex,
    child: Container(
        child: SizedBox(
      width: 50,
    )),
  );
}

class _BottomPicture extends StatelessWidget {
  final String text;

  const _BottomPicture({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
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

class Label extends StatelessWidget {
  const Label({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
        ),
        Text(
          '1. ',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: Colors.black87,
          ),
        ),
        CustomTextField(
          onChanged: (String val) {},
          boxWidth: MediaQuery.of(context).size.width / 3 * 2,
          hintText: '내용을 적어주세요',
          initialValue: null,
          isNumbers: false,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.close),
        )
      ],
    );
  }
}
