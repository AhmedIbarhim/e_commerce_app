import 'package:ecommerce_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildTextFormField extends StatelessWidget {
  late TextEditingController controller;
  late String hintText;
  late IconData prefixIcon;
  Widget? suffixIcon;
  String? Function(String?)? valid;
  TextInputType? keyboardType;
  bool? isPassword;



  BuildTextFormField({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    Widget? this.suffixIcon,
    required String? Function(String?)? this.valid, // search
    TextInputType? this.keyboardType,
    bool? this.isPassword,

  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      style: GoogleFonts.lato(
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      validator: valid,

      keyboardType: keyboardType,
      obscureText: isPassword ?? false, // appear   // lw true hyb2a disappear
      decoration: InputDecoration(
        errorStyle: GoogleFonts.lato(fontWeight: FontWeight.bold),
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: Padding(
          padding: EdgeInsets.only(right: 20, left: 20),
          child: Icon(
            prefixIcon,
            color: AppColor.primaryColor,
          ),
        ),
        hintStyle: GoogleFonts.lato(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
