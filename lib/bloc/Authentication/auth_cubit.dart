import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/authentication_model.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/end_points.dart';
import '../../../network/remote/dio_helper.dart';
import '../../network/local/cash_helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

static  AuthCubit get(context) => BlocProvider.of(context);
AuthenticationModel? authenticationModel; 

Future <void> postRegister(
  { required name,
    required email, 
    required phone,
    required password
  }
    )
  async {
  emit(RegisterLoading());
  DioHelper.postData(
      end_point: REGISTER,
    data: {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password
    }
    
  )
  .then((value){
    authenticationModel = AuthenticationModel.fromJson(value.data);
   // print(value.data);
    emit(RegisterSuccess(
      status: authenticationModel!.status!,
      message: authenticationModel!.message!,
      token: authenticationModel!.status!? authenticationModel!.data!.token! : null,
    )
    );
  })
  .catchError((error){
    print(error.toString());
    emit (RegisterError());
  })
  ;
  }




  Future <void> postLogin(
      {
        required email,
        required password
      }
      )
  async {
    emit(LoginLoading());
    DioHelper.postData(
        end_point: LOGIN,
        data: {
          "email": email,
          "password": password
        }

    )
        .then((value){
      authenticationModel = AuthenticationModel.fromJson(value.data);
     // print(value.data);
      emit(LoginSuccess(
        status: authenticationModel!.status!,
        message: authenticationModel!.message!,
        token: authenticationModel!.status!? authenticationModel!.data!.token! : null,
      )
      );
    })
        .catchError((error){
      print(error.toString());
      emit (LoginError());
    })
    ;
  }

  void getProfileData(){
    emit(GetProfileLoading());
    DioHelper.getData(
      end_point: PROFILE,
      token: CashHelper.getData(key: 'token')??'',
    ).then((value){
      authenticationModel = AuthenticationModel.fromJson(value.data);
      emit(GetProfileSuccess());
     // print(value.data);
    }).catchError((error){
      print(error.toString());
      emit(GetProfileError());
    });
  }


  void updateProfile({
    required String name,
    required String email,
    required String phone,} ){
    emit(UpdateProfileLoading());
   // print(CashHelper.getData(key: 'token'));
    DioHelper.putData(
        end_point: Updated_Profile,
        token: CashHelper.getData(key: 'token')??'',
        data: {
          'name': name,
          'email': email,
          'phone': phone,
        }
    ).then((value){
      authenticationModel = AuthenticationModel.fromJson(value.data);
      emit(UpdateProfileSuccess(

      )
      );
    })
        .catchError((error){
      print(error.toString());
      emit (UpdateProfileError());
    })
    ;
  }

}
