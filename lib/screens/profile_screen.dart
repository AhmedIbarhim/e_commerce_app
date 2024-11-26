import 'package:ecommerce_app/bloc/Authentication/auth_cubit.dart';
import 'package:ecommerce_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/App_Cubit/app_cubit.dart';
import '../shared/components/components.dart';
import '../shared/widgets/button.dart';
import '../shared/widgets/text.dart';
import '../shared/widgets/text_field.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  String? validName(String? value){
    if(value!.isEmpty){
      return 'Please Enter Your Name';
    }
  }

  String? validEmail(String? value){
    if(value!.isEmpty){
      return 'Please Enter Your Email';
    }
  }

  String? validPhone(String? value){
    if(value!.isEmpty){
      return 'Please Enter Your phone';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
        nameController.text= AuthCubit.get(context).authenticationModel!.data!.name!;
        emailController.text= AuthCubit.get(context).authenticationModel!.data!.email!;
        phoneController.text= AuthCubit.get(context).authenticationModel!.data!.phone!;
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);

        return Scaffold(
            backgroundColor: AppColor.primaryColor,
            body: SingleChildScrollView(
              child: SizedBox(
                width: width,
                height: height,
                child: Stack(
                    children:[
                      Padding(
                        padding:  EdgeInsets.symmetric(
                            horizontal: width * 0.05, vertical: height*0.1
                        ),
                        child: Column(
                          children: [
                            BuildText(
                              text: "Update",
                              size: 35,
                              bold: true,
                              color: Colors.white,
                            ),
                            SizedBox(height: height*0.02,),
                            BuildText(
                              text: "Update Your Profile",
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
                              height: height*0.6,
                              width: width,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                ),
                                color: Colors.white,
                              ),
                              child: state is GetProfileLoading?buildLoadingWidget():

                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: width*0.05),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                    BuildTextFormField(
                                    controller: nameController,
                                    hintText: 'name',
                                   // initialValue: 'cubit.authenticationModel!.data!.name',
                                    valid: validName,
                                    prefixIcon: Icons.person,
                                  ),
                                    SizedBox(height:height*0.02),
                                    BuildTextFormField(
                                      controller: emailController,
                                      hintText: 'email',
                                    //  initialValue: cubit.authenticationModel!.data!.email,
                                      valid: validEmail,
                                      prefixIcon: Icons.email,
                                    ),
                                    SizedBox(height:height*0.02),
                                    BuildTextFormField(
                                      controller: phoneController,
                                      hintText: 'phone',
                                     // initialValue: cubit.authenticationModel!.data!.phone,
                                      valid: validPhone,
                                      prefixIcon: Icons.phone,
                                    ),
                                    SizedBox(height:height*0.02),
                                        state is RegisterLoading ? buildLoadingWidget() :
                                    BuildButton(
                                      height: height*0.05,
                                      width: width*0.4,
                                      text: 'Update',
                                      function: (){
                                        if(formKey.currentState!.validate()){
                                          cubit.updateProfile(
                                            name: nameController.text,
                                            email: emailController.text,
                                            phone: phoneController.text,
                                          );
                                        }
                                      },
                                    ),
                                    SizedBox(height: height*0.02,),
                                      ]
                                  ),
                                ),
                              )
                          )
                      )
                    ]
                ),

              ),
            )
        );
      },
    );
  }
}
