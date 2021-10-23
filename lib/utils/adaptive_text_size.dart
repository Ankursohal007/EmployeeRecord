import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum SizeType {SP,H,W,O}
class AdaptiveTextSize {

  static getAdaptiveSize(double value, context,{SizeType type = SizeType.O}) {
    if(type == SizeType.SP) {
      return value.sp;
    } else if(type == SizeType.W) {
      return value.w;
    } else if(type == SizeType.H) {
      return value.h;
    } else {
      return (value / 720) * MediaQuery.of(context).size.height;
    }
  }
}

class ConstTextSize{

  static final ultraSmall = 8.sp;
  static final small = 10.sp;
  static final medium = 14.sp;
  static final large = 18.sp;
  static final ultraLarge = 22.sp;

  static final double spaceVerticalSmall = 15.h;
  static final double spaceVerticalMedium = 30.h;
  static final double spaceVerticalLarge = 45.h;

  static Widget kVerticalSpace({double height = 10}) => SizedBox(height: height);
  static Widget kHorizontalSpace({double width = 10}) => SizedBox(width: width);


}
