
import 'package:flutter/material.dart';

class BorderRadiusEffect extends BoxDecoration {
  final Color? borderColor;
  final double borderWidth;
  final double borderRadiusNum;
  final Color boxColor;
  final bool enableTopLeft;
  final bool enableTopRight;
  final bool enableBottomLeft;
  final bool enableBottomRight;
  final bool showShadow;
  final bool showGradient;
  final AlignmentGeometry gradientBegin;
  final AlignmentGeometry gradientEnd;
  final List<Color> gradientColors;
  final List<double> gradientStops;
  final double shadowOpacity;
  final double spreadRadius;
  final double blurRadius;
  final double offsetX;
  final double offsetY;

  BorderRadiusEffect({
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderRadiusNum = 13.0,
    this.boxColor = const Color(0xFFFFFFFF),
    this.enableTopLeft = true,
    this.enableTopRight = true,
    this.enableBottomLeft = true,
    this.enableBottomRight = true,
    this.showShadow = false,
    this.showGradient = false,
    this.gradientBegin = FractionalOffset.topCenter,
    this.gradientEnd = FractionalOffset.bottomCenter,
    this.gradientColors = const [ Color(0XFFFFFFFF), Color(0XFFFFFFFF)],
    this.gradientStops = const [0.0, 1.0],
    this.shadowOpacity = 0.5,
    this.spreadRadius = 0.5,
    this.blurRadius = 5,
    this.offsetX = 0,
    this.offsetY = 3,
  }):
      super(
          border: (borderColor != null) ? Border.all(width: borderWidth, color: borderColor) : null,
          color: boxColor,
          borderRadius: BorderRadius.only(
            topLeft: (enableTopLeft) ? Radius.circular(borderRadiusNum) : Radius.zero,
            topRight: (enableTopRight) ? Radius.circular(borderRadiusNum) : Radius.zero,
            bottomLeft: (enableBottomLeft) ? Radius.circular(borderRadiusNum) : Radius.zero,
            bottomRight: (enableBottomRight) ? Radius.circular(borderRadiusNum) : Radius.zero
          ),
          gradient: (showGradient) ? new LinearGradient(
            begin: gradientBegin,
            end: gradientEnd,
            colors: gradientColors,
            stops: gradientStops
          ) : null,
          boxShadow: (showShadow) ? [
            BoxShadow(
              //color: Colors.grey.withOpacity(shadowOpacity),
              color: Color(0x26000000),
              spreadRadius: spreadRadius,
              blurRadius: blurRadius,
              offset: Offset(offsetX, offsetY), // changes position of shadow
            ),
          ]: []
      );
}