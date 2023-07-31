import 'package:flutter/material.dart';
import 'package:generating_random_number/const/custom_text_field.dart';

class TopNumberGenerator extends StatelessWidget {
  final bool isDuplicate;
  final GestureTapCallback onDuplicationBoxTap;
  final ValueChanged<String>? onMinimumNumberChanged;
  final ValueChanged<String>? onMaximumNumberChanged;
  final ValueChanged<String>? onCountChanged;

  const TopNumberGenerator({
    required this.isDuplicate,
    required this.onDuplicationBoxTap,
    required this.onMaximumNumberChanged,
    required this.onCountChanged,
    required this.onMinimumNumberChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopEnterNumber(
          onDuplicationBoxTap: onDuplicationBoxTap,
          isDuplicate: isDuplicate,
          onMinimumNumberChanged: onMinimumNumberChanged,
          onCountChanged: onCountChanged,
          onMaximumNumberChanged: onMaximumNumberChanged,
        ),
      ],
    );
  }
}

class _TopEnterNumber extends StatelessWidget {
  final bool isDuplicate;
  final GestureTapCallback onDuplicationBoxTap;
  final ValueChanged<String>? onMinimumNumberChanged;
  final ValueChanged<String>? onMaximumNumberChanged;
  final ValueChanged<String>? onCountChanged;

  const _TopEnterNumber({
    required this.onDuplicationBoxTap,
    required this.isDuplicate,
    required this.onCountChanged,
    required this.onMaximumNumberChanged,
    required this.onMinimumNumberChanged,
  });

  @override
  Widget build(BuildContext context) {
    const TextStyle customTextStyle =
        TextStyle(fontWeight: FontWeight.w600, fontSize: 30);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _MinimumNumberTextField(
              onMinimumNumberChanged: onMinimumNumberChanged,
            ),
            const Text(
              " 에서  ",
              style: customTextStyle,
            ),
            _MaximumNumberTextField(
              onMaximumNumberChanged: onMaximumNumberChanged,
            ),
            const Text(
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
            const Text(
              " 개 숫자 생성!",
              style: customTextStyle,
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        _Duplication(
          isDuplicate: isDuplicate,
          onBoxTap: onDuplicationBoxTap,
        ),
      ],
    );
  }
}

class _Duplication extends StatelessWidget {
  final bool isDuplicate;
  final GestureTapCallback onBoxTap;

  const _Duplication({
    required this.isDuplicate,
    required this.onBoxTap,

  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "중복 숫자 허용",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 22,
            height: 1,
          ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: onBoxTap,
          child: Container(
            child: isDuplicate
                ? const Icon(
                    Icons.check_box_outlined,
                    size: 30,
                  )
                : const Icon(
                    Icons.check_box_outline_blank_rounded,
                    size: 30,
                  ),
          ),
        )
      ],
    );
  }
}

class _MinimumNumberTextField extends StatelessWidget {
  final ValueChanged<String>? onMinimumNumberChanged;

  const _MinimumNumberTextField({
    required this.onMinimumNumberChanged,

  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      onChanged: onMinimumNumberChanged,
      initialValue: null,
      hintText: "최솟값",
      boxWidth: 80,
      isNumbers: true,
    );
  }
}

class _MaximumNumberTextField extends StatelessWidget {
  final ValueChanged<String>? onMaximumNumberChanged;

  const _MaximumNumberTextField({
    required this.onMaximumNumberChanged,

  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      onChanged: onMaximumNumberChanged,
      initialValue: null,
      hintText: "최댓값",
      boxWidth: 80,
      isNumbers: true,
    );
  }
}

class _GenerationCount extends StatelessWidget {
  final ValueChanged<String>? onCountChanged;

  const _GenerationCount({
    required this.onCountChanged,

  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      onChanged: onCountChanged,
      initialValue: null,
      hintText: "생성 개수",
      boxWidth: 100,
      isNumbers: true,
    );
  }
}
