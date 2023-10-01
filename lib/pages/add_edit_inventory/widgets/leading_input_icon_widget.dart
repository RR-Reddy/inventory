import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LeadingInputIconWidget extends StatelessWidget {
  const LeadingInputIconWidget({
    Key? key,
    required this.icon,
    this.padding,
  }) : super(key: key);

  final EdgeInsets? padding;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 8.w,
      child: Padding(
        padding: padding ?? EdgeInsets.only(bottom: 2.h),
        child: Icon(icon),
      ),
    );
  }
}