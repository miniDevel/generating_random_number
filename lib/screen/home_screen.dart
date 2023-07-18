import 'package:flutter/material.dart';
import 'package:generating_random_number/component/bottom_picture.dart';
import 'package:generating_random_number/component/custom_button.dart';
import 'package:generating_random_number/component/custom_text_field.dart';
import 'package:generating_random_number/component/custom_screen.dart';
import 'package:generating_random_number/screen/result_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: CustomScreenContainer(
              children: [
                SizedBox(height: 120),
                TopTexture(),
                SizedBox(height: 120),
                MiddleButton(),
                Expanded(
                  child: BottomPicture(
                    child: Stack(
                      children: [
                        Image.asset('assets/img/home_screen.png'),
                        Positioned(
                          top: 50,
                          right: 50,
                          child: Text(
                            '위에 입력하면 내가 숫자를 말해줄게!',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
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

class MiddleButton extends StatelessWidget {
  const MiddleButton({super.key});

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
