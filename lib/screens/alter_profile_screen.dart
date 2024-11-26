import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Authentication/auth_cubit.dart';
import '../network/local/cash_helper.dart';
import '../shared/components/components.dart';
import '../shared/widgets/button.dart';
import '../shared/widgets/text.dart';
import '../shared/widgets/text_field.dart';
import 'login_screen.dart';

class AlterProfileScreen extends StatefulWidget {
  AlterProfileScreen({super.key});

  @override
  State<AlterProfileScreen> createState() => _AlterProfileScreenState();
}
class _AlterProfileScreenState extends State<AlterProfileScreen> {
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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit  = AuthCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: BuildText(text: 'profile',bold: true,color: Colors.black,),
            centerTitle: true,
            leading: Icon(Icons.menu,color: Colors.black,),
            actions: [
              IconButton(
                  onPressed: (){
                    CashHelper.removeData(key: 'token').then((value) {
                      navigateTo(context, LoginScreen()
                      );
                    }
                    );
                  },
                  icon: Icon(Icons.logout,color: Colors.black,))
            ],
          ),
          body:cubit.authenticationModel==null?buildLoadingWidget():
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BuildTextFormField(
                    controller: nameController,
                    hintText: 'name',
                    valid: validName,
                    prefixIcon: Icons.person,
                  ),
                  SizedBox(height:height*0.02),
                  BuildTextFormField(
                    controller: emailController,
                    hintText: 'email',
                    valid: validEmail,
                    prefixIcon: Icons.email,
                  ),
                  SizedBox(height:height*0.02),
                  BuildTextFormField(
                    controller: phoneController,
                    hintText: 'phone',
                    valid: validPhone,
                    prefixIcon: Icons.phone,
                  ),
                  SizedBox(height:height*0.02),
                  BuildButton(
                    height: height*0.08,
                    width: width,
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
                  // BuildButton(
                  //     height: height*0.08,
                  //     width: width,
                  //     text: 'Logout',
                  //     function:(){
                  //     CashHelper.removeData(key: 'token').then((value){
                  //       navigateTo(context, LoginScreen());
                  //     }
                  //     );
                  //     }
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

