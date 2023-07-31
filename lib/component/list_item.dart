import 'package:flutter/material.dart';
import 'package:generating_random_number/const/custom_text_field.dart';

class ListItem extends StatelessWidget {
  final TextEditingController controller;
  final List<String> listItems;
  final VoidCallback onDeleteIcon;
  final int index;
  const ListItem({
    required this.controller,
    required this.onDeleteIcon,
    required this.listItems,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 20),
          Text(
            '${index + 1}. ',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
          CustomTextField(
              controller: controller,
              isNumbers: false,
              onChanged: (value) {
                listItems[index] = value;
              },
              boxWidth: MediaQuery.of(context).size.width / 3 * 2,
              hintText: '내용을 적어주세요',
              initialValue: null),
          index == 0 || index != listItems.length - 1
              ? const SizedBox(width: 50)
              : IconButton(
                  onPressed: onDeleteIcon,
                  icon: const Icon(Icons.close),
                ),
        ],
      ),
    );

  }
}
