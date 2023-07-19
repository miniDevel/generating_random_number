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

  @override
  Widget build(BuildContext context) {
    final emptySpaceHeight = (MediaQuery.of(context).size.height -
        70 -
        getTopTextureHeight() -
        getMiddleButtonHeight() -
        getStackHeight());

    SizedBox EmptySpaceHeight(){
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
                    key: topTextureKey,
                  ),
                  EmptySpaceHeight(),
                  _MiddleButton(
                    key: middleButtonKey,
                  ),
                  EmptySpaceHeight(),
                  _BottomPicture(
                      stackKey: stackKey, text: currentText),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
  const _TopTexture({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle customTextStyle =
        TextStyle(fontWeight: FontWeight.w600, fontSize: 30);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              initialValue: null,
              hintText: "최솟값",
              boxWidth: 80,
            ),
            Text(
              " 에서  ",
              style: customTextStyle,
            ),
            CustomTextField(
              initialValue: null,
              hintText: "최댓값",
              boxWidth: 80,
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
            CustomTextField(
              initialValue: null,
              hintText: "생성 개수",
              boxWidth: 100,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "중복 숫자 허용",
              style: customTextStyle.copyWith(
                  fontSize: 22, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}

class _MiddleButton extends StatelessWidget {
  const _MiddleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        child: Text(
          "생성 하기",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ResultScreen()),
          );
        });
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
          top: 50,
          right: 50,
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
