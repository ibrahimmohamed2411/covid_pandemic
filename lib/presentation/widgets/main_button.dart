import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_button.dart';

class MainButton extends StatelessWidget {
  final String title;
  final Color? color;
  final Function()? onPressed;
  const MainButton({
    Key? key,
    required this.title,
    this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      child: Text(
        title,
        style: TextStyle(fontSize: 18.sp),
        textAlign: TextAlign.center,
      ),
      color: color ?? Theme.of(context).primaryColor,
      onPressed: onPressed,
    );
  }
}
