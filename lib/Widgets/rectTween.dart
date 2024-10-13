
import 'package:flutter/widgets.dart';

class CustomRectTween extends RectTween {
  /// {@macro custom_rect_tween}
  CustomRectTween({
    required Rect begin,
    required Rect end,
  }): super(begin: begin, end: end);

  @override
  Rect? lerp(double t) {
   // final elasticCurveValue = Curves.easeOut.transform(t);
    return Rect.fromCenter(center: const Offset(6,6), width:100 , height: 100);
  }
}