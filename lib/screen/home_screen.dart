import 'package:flutter/material.dart';
import 'package:generating_random_number/component/top_list_generator.dart';
import 'package:generating_random_number/component/choose_butteon.dart';
import 'package:generating_random_number/component/top_number_generator.dart';
import 'package:generating_random_number/const/colors.dart';
import 'package:generating_random_number/const/empty_space.dart';
import 'package:generating_random_number/component/middle_button.dart';
import 'package:generating_random_number/screen/result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TextEditingController> textControllers = [
    TextEditingController(),
    TextEditingController()
  ];
  List<String> listItems = ['', ''];
  String currentText = '어떤걸 도와줄까?';
  String? maximumNumber;
  String? minimumNumber;
  int? generationCount;
  bool isDuplicate = false;
  bool? isGeneratingNumbers;
  final String selectedListItemText = '리스트를 작성하면 내가 골라줄게!';
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
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                isGeneratingNumbers == null || isGeneratingNumbers!
                    ? emptySpace(3)
                    : const SizedBox(),
                isGeneratingNumbers == null
                    ? ChooseButton(
                        onTopPressed: onTopPressed,
                        topLabel: "랜덤숫자생성",
                        onBottomPressed: onBottomPressed,
                        bottomLabel: "리스트만들기",
                      )
                    : const SizedBox(),
                isGeneratingNumbers == null
                    ? const SizedBox()
                    : !isGeneratingNumbers!
                        ? TopListGenerator(
                            onAddListItem: onAddListItem,
                            onCountChanged: onCountChanged,
                            textControllers: textControllers,
                            listItems: listItems,
                            onInitializeButton: onInitializeButton,
                            onDeleteIcon: onDeleteIcon,
                          )
                        : TopNumberGenerator(
                            isDuplicate: isDuplicate,
                            onDuplicationBoxTap: onDuplicationBoxTap,
                            onMaximumNumberChanged: onMaximumNumberChanged,
                            onCountChanged: onCountChanged,
                            onMinimumNumberChanged: onMinimumNumberChanged,
                          ),
                isGeneratingNumbers == null || isGeneratingNumbers!
                    ? emptySpace(2)
                    : const SizedBox(),
                isGeneratingNumbers != null
                    ? MiddleButton(
                        onGenerateButtonPressed: isGeneratingNumbers!
                            ? onNumberGenerateButtonPressed
                            : onListGenerateButtonPressed,
                        onModeChangeButtonPressed: onModeChangeButtonPressed,
                      )
                    : const SizedBox(),
                _BottomPicture(text: currentText),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 마지막 index를 가진 ListItem의 x 아이콘을 누르면 마지막 index 삭제
  onDeleteIcon() {
    setState(() {
      listItems.removeAt(listItems.length - 1);
      textControllers.removeAt(listItems.length - 1);
      if (listItems.length == 1) {
        currentText = '항목은 두개 이상으로 해줘!';
      }
    });
  }

  // 리스트만들기에서 작성 초기화 버튼
  onInitializeButton() {
    const TextStyle customTextStyle = TextStyle(
        fontWeight: FontWeight.w600, fontSize: 20, color: Colors.grey);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            '전부 삭제할까요?',
            style: customTextStyle.copyWith(
              color: Colors.black87,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(
                  () {
                    listItems = ['', ''];
                    textControllers = [
                      TextEditingController(),
                      TextEditingController()
                    ];
                    for (var controller in textControllers) {
                      controller.clear();
                    }
                  },
                );
                Navigator.of(context).pop();
              },
              child: const Text(
                '예',
                style: customTextStyle,
              ),
            ),
            const SizedBox(width: 10),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                '아니오',
                style: customTextStyle,
              ),
            ),
          ],
        );
      },
    );
  }

  // 항목추가+ 버튼을 누르면 작성할 수 있는 index 추가
  onAddListItem() {
    setState(() {
      listItems.add('');
      if (listItems.length == 2) {
        currentText = '리스트를 작성하면 내가 골라줄게!';
      }
    });
  }

  // 첫 화면에서 모드를 랜덤 숫자 생성기로 설정
  onTopPressed() {
    setState(() {
      currentText = selectedNumberText;
      isGeneratingNumbers = true;
    });
  }

  // 첫 화면에서 모드를 리스트 선택으로 설정
  onBottomPressed() {
    setState(() {
      currentText = selectedListItemText;
      isGeneratingNumbers = false;
      generationCount = 1;
    });
  }

  // 중복 버튼 on/off
  onDuplicationBoxTap() {
    setState(() {
      isDuplicate = !isDuplicate;
    });
  }

  // 작성한 리스트에서 랜덤으로 선택 버튼
  onListGenerateButtonPressed() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (listItems.length < 2) {
      setState(() {
        currentText = '두개 이상 있어야 된다니까?!';
      });
    } else {
      if (listItems.contains('')) {
        setState(() {
          currentText = '빈 항목을 작성해줘!';
        });
      } else {
        if (generationCount == null) {
          setState(() {
            currentText = '몇개를 골라줄까?';
          });
        } else {
          if (listItems.length < generationCount!) {
            setState(() {
              currentText = '그렇게 고를 수는 없는걸..?';
            });
          } else {
            if (generationCount == 0) {
              setState(() {
                currentText = '0개는 고를 수 없어!';
              });
            } else {
              if (listItems.length == generationCount) {
                setState(() {
                  currentText = '전부다 선택하면 되는거야..?';
                });
              } else {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (_) => ResultScreen(
                      listItems: listItems,
                      generationCount: generationCount!,
                      isNumberGenerating: false,
                    ),
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
      }
    }
  }

  // 랜덤숫자 생성 버튼
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
                  isDuplicate: isDuplicate,
                  isNumberGenerating: true,
                ),
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

  // 모드 변경 버튼
  onModeChangeButtonPressed() {
    setState(() {
      isGeneratingNumbers = !isGeneratingNumbers!;
      if (isGeneratingNumbers!) {
        currentText = selectedNumberText;
        generationCount = null;
      } else {
        currentText = selectedListItemText;
        generationCount = 1;
      }
      maximumNumber = null;
      minimumNumber = null;
    });
  }

  // 최솟값 변경 함수
  onMinimumNumberChanged(String? val) {
    if (val!.isEmpty) {
      minimumNumber = null;
    } else {
      minimumNumber = val;
    }
  }

  // 최댓값 변경 함수
  onMaximumNumberChanged(String? val) {
    if (val!.isEmpty) {
      maximumNumber = null;
    } else {
      maximumNumber = val;
    }
  }

  // 생성 개수 변경 함수
  onCountChanged(String? val) {
    if (val!.isEmpty) {
      generationCount = null;
    } else {
      generationCount = int.parse(val);
    }
  }
}

class _BottomPicture extends StatelessWidget {
  final String text;

  const _BottomPicture({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/img/home_screen.png'),
        Positioned(
          top: 52,
          right: 42,
          child: SizedBox(
            width: 330,
            child: Center(
              child: Text(
                text,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
