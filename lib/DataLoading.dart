import 'package:flutter/material.dart';

import 'BorderRadiusEffect.dart';

class DataLoading extends StatelessWidget {
  final double strokeWidth;
  final double width;
  final double height;
  final double padding;
  final Color backgroundColor;

  const DataLoading({Key? key,
    this.strokeWidth = 2.0,
    this.width = 38,
    this.height = 38,
    this.padding = 10,
    this.backgroundColor = Colors.white
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
          width: width,
          height: height,
          child: Container(
            padding: EdgeInsets.all(padding),
            decoration: BorderRadiusEffect(
              borderRadiusNum: 100.0,
              boxColor: backgroundColor
            ),
            child: CircularProgressIndicator(
                strokeWidth: strokeWidth,
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)
            )
          )
        )
    );
  }
}