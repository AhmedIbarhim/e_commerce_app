import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/shared/widgets/text.dart';
import 'package:flutter/material.dart';

class BuildTextButton extends StatelessWidget {
  var text;
  var function;
  BuildTextButton({required this.text, required this.function});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: function,
        child: BuildText(text: text),
    );
  }
}

