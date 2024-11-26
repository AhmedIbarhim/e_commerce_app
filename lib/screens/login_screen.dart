import 'package:awesome_icons/awesome_icons.dart';
import 'package:ecommerce_app/bloc/Authentication/auth_cubit.dart';
import 'package:ecommerce_app/network/local/cash_helper.dart';
import 'package:ecommerce_app/screens/home_layout.dart';
import 'package:ecommerce_app/screens/register_screen.dart';
import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:ecommerce_app/shared/widgets/button.dart';
import 'package:ecommerce_app/shared/widgets/text.dart';
import 'package:ecommerce_app/shared/widgets/text_button.dart';
import 'package:ecommerce_app/shared/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool show = false;
  IconData icon = FontAwesomeIcons.eyeSlash;

  String? emailValid(String? value) {
    if (value!.isEmpty) {
      return "Please Enter your Email";
    }
  }

  String? passwordValid(String? value) {
    if (value!.isEmpty) {
      return "Please Enter your Password";
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          if (state.status == true) {
            var snackBar = buildAwesomeSnackBar(
                typeCode: 1, title: "Success", message: state.message);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            navigateToFinish(context, HomeLayout());
            CashHelper.putData(key: 'token', value: state.token);
          } else {
            var snackBar = buildAwesomeSnackBar(
                typeCode: 0, title: "Fail", message: state.message);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
            backgroundColor: AppColor.primaryColor,
            body: SingleChildScrollView(
              child: SizedBox(
                width: width,
                height: height,
                child: Stack(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05, vertical: height * 0.1),
                    child: Column(
                      children: [
                        BuildText(
                          text: "Login",
                          size: 35,
                          bold: true,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        BuildText(
                          text: "Welcome to App Store",
                          size: 15,
                          bold: true,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
                          height: height * 0.6,
                          width: width,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.05),
                            child: Form(
                              key: formKey,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BuildTextFormField(
                                        controller: emailController,
                                        hintText: "Email",
                                        prefixIcon: Icons.email,
                                        valid: emailValid),
                                    SizedBox(height: height * 0.02),
                                    BuildTextFormField(
                                      controller: passwordController,
                                      hintText: "Password",
                                      prefixIcon: Icons.password,
                                      valid: passwordValid,
                                      isPassword: !show,
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.only(
                                            right: width * 0.04),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (show) {
                                                show = !show;
                                                icon =
                                                    FontAwesomeIcons.eyeSlash;
                                              } else {
                                                show = !show;
                                                icon = FontAwesomeIcons.eye;
                                              }
                                            });
                                          },
                                          child: Icon(icon,
                                              color: AppColor.primaryColor),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        BuildTextButton(
                                            text: "Don't have an account?",
                                            function: () {
                                              navigateToFinish(
                                                  context, RegisterScreen());
                                            }),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    state is LoginLoading
                                        ? buildLoadingWidget()
                                        : BuildButton(
                                            height: height * 0.05,
                                            width: width * 0.4,
                                            text: "Sign In",
                                            function: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                cubit.postLogin(
                                                    email: emailController.text,
                                                    password: passwordController
                                                        .text);
                                              }
                                            }),
                                  ]),
                            ),
                          )))
                ]),
              ),
            ));
      },
    );
  }
}
