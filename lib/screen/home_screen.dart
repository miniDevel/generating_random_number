import 'package:flutter/material.dart';
import 'package:generating_random_number/component/custom_text_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
          TopTexture(),
          MiddleButton(),
          BottomPicture(),
          ],
        ),
      ),
    );
  }
}

class TopTexture extends StatelessWidget {
  const TopTexture({super.key});

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
              boxWidth: 100,
            ),
            Text(
              " 에서  ",
              style: customTextStyle,
            ),
            CustomTextField(
              initialValue: null,
              hintText: "최댓값",
              boxWidth: 100,
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
              boxWidth: 50,
            ),
            Text(
              " 개 숫자 생성!",
              style: customTextStyle,
            )
          ],
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


class BottomPicture extends StatelessWidget {
  const BottomPicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset('assets/img/home_screen.png'),
      Positioned(
        top: 50,
        right: 50,
        child: Text(
          '위를 입력하면 내가 숫자를 말해줄게!',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
    ]);
  }
}

class MiddleButton extends StatelessWidget {
  const MiddleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){}, child: Text("생성 하기"));
  }
}
