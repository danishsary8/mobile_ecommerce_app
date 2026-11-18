import 'package:flutter/animation.dart';

abstract class MotionCurves {
  // Editorial fluid motion curves
  static const Curve smooth = Curves.easeInOutCubic;
  static const Curve decelerate = Curves.easeOutCubic;
  static const Curve energeticSpring = Curves.easeOutBack;
  static const Curve fluidIn = Curves.easeInCubic;

  // Standard animation durations
  static const Duration micro = Duration(milliseconds: 150);
  static const Duration fast = Duration(milliseconds: 250);
  static const Duration regular = Duration(milliseconds: 350);
  static const Duration smoothTransition = Duration(milliseconds: 450);
  static const Duration modalPresentation = Duration(milliseconds: 500);
}
