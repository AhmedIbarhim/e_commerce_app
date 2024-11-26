import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/shared/widgets/text.dart';
import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {
  var height;
  var width;
  var text;
  var function;
  Color? color;

  BuildButton(
      {required this.height,
      required this.width,
      required this.text,
      required this.function,
      this.color});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        height: height,
        width: width,
        child: MaterialButton(
            onPressed: function,
            child: BuildText(text: text, color: Colors.white),
            color: color ?? AppColor.primaryColor),
      ),
    );
  }
}
