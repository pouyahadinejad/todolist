import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todolist/main.dart';

class MyCheckBox extends StatelessWidget {
  final bool value;
  final GestureTapCallback onTap;
  const MyCheckBox({Key? key, required this.value, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border:
              !value ? Border.all(color: secondaryTextColor, width: 2) : null,
          color: value ? primaryColor : null,
        ),
        child:
            value
                ? Icon(
                  CupertinoIcons.check_mark,
                  size: 16,
                  color: themeData.colorScheme.onPrimary,
                )
                : null,
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/empty_state.svg', width: 120),
        const SizedBox(height: 12),
        const Text('Your task list is empty'),
      ],
    );
  }
}
