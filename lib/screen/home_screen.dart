import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle customTextStyle =
        TextStyle(fontWeight: FontWeight.w600, fontSize: 22);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "에서",
                        style: customTextStyle,
                      ),
                      Text(
                        "까지",
                        style: customTextStyle,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "개 숫자 생성!",
                        style: customTextStyle,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "중복 숫자 허용",
                        style: customTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            BottomPicture(),
            SizedBox(height: 100),
          ],
        ),
      ),
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
