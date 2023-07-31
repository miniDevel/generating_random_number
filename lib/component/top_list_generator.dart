import 'package:flutter/material.dart';
import 'package:generating_random_number/const/custom_text_field.dart';
import 'package:generating_random_number/component/list_item.dart';

class TopListGenerator extends StatelessWidget {
  final VoidCallback onDeleteIcon;
  final VoidCallback onInitializeButton;
  final VoidCallback onAddListItem;
  final ValueChanged<String> onCountChanged;
  final List<String> listItems;
  final List<TextEditingController> textControllers;

  const TopListGenerator({
    required this.onDeleteIcon,
    required this.onInitializeButton,
    required this.onAddListItem,
    required this.onCountChanged,
    required this.textControllers,
    required this.listItems,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  listItems.length,
                  (index) {
                    if (listItems.length > textControllers.length) {
                      textControllers.add(TextEditingController());
                    }
                    return ListItem(
                      controller: textControllers[index],
                      index: index,
                      onDeleteIcon: onDeleteIcon,
                      listItems: listItems,
                    );
                  },
                ),
              ),
              _UnderBanner(
                onAddListItem: onAddListItem,
                onCountChanged: onCountChanged,
                onInitializeButton: onInitializeButton,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UnderBanner extends StatelessWidget {
  final VoidCallback onInitializeButton;
  final VoidCallback onAddListItem;
  final ValueChanged<String> onCountChanged;
  const _UnderBanner({
    required this.onInitializeButton,
    required this.onAddListItem,
    required this.onCountChanged,
  });

  @override
  Widget build(BuildContext context) {
    const TextStyle customTextStyle = TextStyle(
        fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black87);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '선택 개수: ',
          style: customTextStyle,
        ),
        CustomTextField(
            isNumbers: false,
            onChanged: onCountChanged,
            boxWidth: 40,
            hintText: '',
            initialValue: '1'),
        const SizedBox(width: 20),
        TextButton(
          onPressed: onAddListItem,
          child: const Text(
            '항목추가+',
            style: customTextStyle,
          ),
        ),
        const SizedBox(width: 20),
        IconButton(
          onPressed: onInitializeButton,
          icon: const Icon(
            Icons.delete_forever,
            color: Colors.black87,
          ),
        )
      ],
    );
  }
}
