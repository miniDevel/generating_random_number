import 'package:flutter/material.dart';
import 'package:generating_random_number/component/custom_button.dart';
import 'package:generating_random_number/component/custom_text_field.dart';
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
  String currentText = '위에 입력하면 내가 숫자를 말해줄게!';
  String? maximumNumber;
  String? minimumNumber;
  int? generationCount;

  @override
  Widget build(BuildContext context) {
    final emptySpaceHeight = (MediaQuery.of(context).size.height -
        70 -
        getTopTextureHeight() -
        getMiddleButtonHeight() -
        getStackHeight());

    SizedBox EmptySpaceHeight() {
      return SizedBox(
        height: emptySpaceHeight / 3,
      );
    }

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: WHITE_COLOR,
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 50,
              child: Column(
                children: [
                  EmptySpaceHeight(),
                  _TopTexture(
                    onMinimumNumberChanged: onMinimumNumberChanged,
                    onCountChanged: onCountChanged,
                    onMaximumNumberChanged: onMaximumNumberChanged,
                    key: topTextureKey,
                  ),
                  EmptySpaceHeight(),
                  _MiddleButton(
                    onButtonPressed: onButtonPressed,
                    key: middleButtonKey,
                  ),
                  EmptySpaceHeight(),
                  _BottomPicture(stackKey: stackKey, text: currentText),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onButtonPressed() {
    if (minimumNumber == null ||
        maximumNumber == null ||
        generationCount == null) {
      setState(() {
        currentText = '빈 칸을 전부 입력 해줘~';
      });
    } else {
      int? min = int.tryParse(minimumNumber!);
      int? max = int.tryParse(maximumNumber!);

      if (min == null ||
          max == null ||
          min > max ||
          max - min < generationCount!) {
        setState(() {
          currentText = '너무 많이 만드는거 같아!';
        });
      } else {
        if (generationCount! <= 0) {
          setState(() {
            currentText = '0개는 만들수 없어 ㅠ';
          });
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ResultScreen()),
          );
        }
      }
    }
    FocusScope.of(context).requestFocus(FocusNode());
  }

  onMinimumNumberChanged(String? val) {
    minimumNumber = val;
  }

  onCountChanged(String? val) {
    generationCount = int.parse(val!);
  }

  onMaximumNumberChanged(String? val) {
    maximumNumber = val;
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

class _TopTexture extends StatelessWidget {
  final ValueChanged<String>? onMinimumNumberChanged;
  final ValueChanged<String>? onMaximumNumberChanged;
  final ValueChanged<String>? onCountChanged;
  const _TopTexture({
    required this.onCountChanged,
    required this.onMaximumNumberChanged,
    required this.onMinimumNumberChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle customTextStyle =
        TextStyle(fontWeight: FontWeight.w600, fontSize: 30);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _MinimumNumberTextField(
              onMinimumNumberChanged: onMinimumNumberChanged,
            ),
            Text(
              " 에서  ",
              style: customTextStyle,
            ),
            _MaximumNumberTextField(
              onMaximumNumberChanged: onMaximumNumberChanged,
            ),
            Text(
              " 까지",
              style: customTextStyle,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _GenerationCount(
              onCountChanged: onCountChanged,
            ),
            Text(
              " 개 숫자 생성!",
              style: customTextStyle,
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        _Duplication(),
      ],
    );
  }
}

class _MinimumNumberTextField extends StatelessWidget {
  final ValueChanged<String>? onMinimumNumberChanged;
  const _MinimumNumberTextField({
    required this.onMinimumNumberChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      onChanged: onMinimumNumberChanged,
      initialValue: null,
      hintText: "최솟값",
      boxWidth: 80,
    );
  }
}

class _MaximumNumberTextField extends StatelessWidget {
  final ValueChanged<String>? onMaximumNumberChanged;
  const _MaximumNumberTextField({
    required this.onMaximumNumberChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      onChanged: onMaximumNumberChanged,
      initialValue: null,
      hintText: "최댓값",
      boxWidth: 80,
    );
  }
}

class _GenerationCount extends StatelessWidget {
  final ValueChanged<String>? onCountChanged;
  const _GenerationCount({
    required this.onCountChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      onChanged: onCountChanged,
      initialValue: null,
      hintText: "생성 개수",
      boxWidth: 100,
    );
  }
}

class _Duplication extends StatelessWidget {
  const _Duplication({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "중복 숫자 허용",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22)
        ),
        Icon(Icons.check_box_outline_blank_rounded)
      ],
    );
  }
}


class _MiddleButton extends StatelessWidget {
  final VoidCallback onButtonPressed;
  const _MiddleButton({
    required this.onButtonPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      child: Text(
        "생성 하기",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
      ),
      onPressed: onButtonPressed,
    );
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
