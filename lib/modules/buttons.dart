import 'package:calender_app/shared/components/colors.dart';
import 'package:calender_app/shared/components/text_style.dart';
import 'package:flutter/cupertino.dart';

class DefaultButtons extends StatelessWidget {
  final String label;
  final Function() onTap;
  const DefaultButtons({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: blueColor,
        ),
        child: Center(
          child: Text(
            label,
            style: textButtonStyle(),
          ),
        ),
      ),
    );
  }
}
