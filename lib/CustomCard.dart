import 'dart:async';

import 'package:flutter/material.dart';

import 'AppColor.dart';
import 'ButtonHandler.dart';

class CustomCard extends StatefulWidget {
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool enabled;
  final List<Widget> children;
  final CrossAxisAlignment itemAxisAlignment;
  final EdgeInsetsGeometry? itemPadding;
  final int? longPressDuration;

  const CustomCard({
    Key? key,
    required this.children,
    this.onTap,
    this.onLongPress,
    this.itemAxisAlignment = CrossAxisAlignment.center,
    this.itemPadding,
    this.enabled = true,
    this.longPressDuration,
  }) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCard();
}

class _CustomCard extends State<CustomCard> with ButtonHandler {
  bool _isLongPress = false;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: AppColor.borderColor,
          width: 1,
        ),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 80, // 設置最小高度
        ),
        child: InkWell(
          onTapCancel: widget.onLongPress != null
              ? () => handleButtonClick(
                    "onTapCancel",
                    () {
                      print("onTapCancel");
                      _isLongPress = false;
                      timer?.cancel();
                    },
                  )
              : null,
          onTapDown: widget.onLongPress != null
              ? (_) => handleButtonClick(
                    "onTapDown",
                    () {
                      print("onTapDown");
                      _isLongPress = true;
                      timer = Timer(Duration(seconds: widget.longPressDuration ?? 2), () {
                        if (_isLongPress && widget.onLongPress != null) {
                          widget.onLongPress!();
                        }
                      });
                    },
                  )
              : null,
          onTapUp: widget.onLongPress != null
              ? (_) => handleButtonClick(
                    "onTapUp",
                    () {
                      print("onTapUp");
                      _isLongPress = false;
                      timer?.cancel();
                    },
                  )
              : null,
          onTap: widget.onTap != null
              ? () => handleButtonClick(
                    "onTap",
                    () async => widget.onTap!(),
                  )
              : null,
          borderRadius: BorderRadius.circular(8),
          child: Opacity(
            opacity: widget.enabled ? 1.0 : 0.5,
            child: Padding(
              padding: widget.itemPadding != null ? widget.itemPadding! : EdgeInsets.all(16),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: widget.itemAxisAlignment,
                  children: widget.children,
                ),
              ),
            ),
          ),
        ), // 指定要限制高度的 Widget
      ),
    );
  }
}
