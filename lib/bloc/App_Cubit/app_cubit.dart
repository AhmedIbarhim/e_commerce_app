import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/cart_model.dart';
import 'package:ecommerce_app/models/category_products_model.dart';
import 'package:ecommerce_app/models/change_cart_model.dart';
import 'package:ecommerce_app/models/change_favourite_model.dart';
import 'package:ecommerce_app/models/favourite_model.dart' as favo;
import 'package:ecommerce_app/models/home_model.dart';
import 'package:ecommerce_app/models/search_model.dart';
import 'package:ecommerce_app/network/local/cash_helper.dart';
import 'package:ecommerce_app/screens/category_screen.dart';
import 'package:ecommerce_app/screens/favourite_screen.dart';
import 'package:ecommerce_app/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/category_model.dart';
import '../../models/home_model.dart';
import '../../network/end_points.dart';
import '../../network/remote/dio_helper.dart';
import '../../screens/cart_screen.dart';
import '../../screens/alter_profile_screen.dart';
import '../../models/favourite_model.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  List<Widget> myScreens = [
    HomeScreen(),
    CategoryScreen(),
    FavouriteScreen(),
    CartScreen(),
  ];
  int currentIndexScreen = 0;
  int currentIndexSlider = 0;

  static AppCubit get(context) => BlocProvider. of(context);

  HomeModel? homeModel;
  CategoryModel? categoryModel;
  CategoryProductsModel? categoryProductsModel;
  ChangeFavouriteModel? changeFavouriteModel;
  FavouriteModel? favouriteModel;
  ChangeCartModel? changeCartModel;
  CartModel? cartModel;
  SearchModel? searchModel;

 // List<favo.Product> carts = [];
  List<num> cart = [];

  void changeScreen(int index) {
    currentIndexScreen = index;
    if(index == 3){
      getCart();
    }
    else if (index == 2){
      getFavourites();
    }
    emit(ChangeCurrentIndexScreen());
  }

  void changeSliderIndex(int index) {
    currentIndexSlider = index;
    emit(ChangeCurrentIndexSlider());
  }


  Future<void> getHomeData()async{
    emit(GetHomeLoading());
    DioHelper.getData(
      token: CashHelper.getData(key: 'token') ?? '',
      end_point: HOME,
    )
    .then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products!.forEach((element) {
        if(element.inCart!){
          cart.add(element.id!);
        }
      });
      emit(GetHomeSuccess());
      // homeModel!.data!.products!.forEach((element) {print(element.name);});
    })
    .catchError((error){
      print(error.toString());
      emit(GetHomeError());
    })
    ;
  }


  Future<void> getCategoryData()async{
    emit(GetCategoryLoading());
    DioHelper.getData(
      end_point: CATEGORY,
    )
        .then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(GetCategorySuccess());
    })
        .catchError((error){
      print(error.toString());
      emit(GetCategoryError());
    })
    ;
  }

  void getCategoryProducts({required num id}){
    categoryProductsModel = null;
    emit (GetCategoryProductsLoading());
    DioHelper.getData(
        end_point: CATEGORYDETAILS,
      token: CashHelper.getData(key: 'token')?? '',
      query: {
          'category_id' : id,
      }
    )
        .then((value) {
      categoryProductsModel = CategoryProductsModel.fromJson(value.data);
      emit(GetCategoryProductsSuccess());
    })
        .catchError((error){
          print(error.toString());
          emit(GetCategoryProductsError());
        })
    ;
  }

  Future <void> postChangeFavourite({required int id})async{
    emit(ChangeFavouriteLoading());
    await DioHelper.postData(
        end_point: FAVOURITE,
      data: {
          'product_id' : id
      },
      token: CashHelper.getData(key: 'token') ?? ''
    )
    .then((value) {

      changeFavouriteModel = ChangeFavouriteModel.fromJson(value.data);
      emit(ChangeFavouriteSuccess());
    })
    .catchError((error){
      print(error.toString());
      emit(ChangeFavouriteError());
    })
    ;
  }

  void changeFavouriteInSales({required int index}){
    if(homeModel!.data!.sales[index].inFavourites!){
      homeModel!.data!.sales[index].inFavourites = false;
    }
    else{
      homeModel!.data!.sales[index].inFavourites = true;
    }
    emit(ChangeFavourite());

  }


  void changeFavouriteInProducts({required int index}){
    if(homeModel!.data!.products![index].inFavourites!){
      homeModel!.data!.products![index].inFavourites = false;
    }
    else{
      homeModel!.data!.products![index].inFavourites = true;
    }
    emit(ChangeFavourite());

  }

  void changeFavouriteInCategories({required int index}){
    if(categoryProductsModel!.data!.products![index].inFavourites!){
      categoryProductsModel!.data!.products![index].inFavourites = false;
    }
    else{
      categoryProductsModel!.data!.products![index].inFavourites = true;
    }
    emit(ChangeFavourite());
  }


  Future<void> getFavourites()async{
    emit(GetFavouritesLoading());
    DioHelper.getData(
      end_point: FAVOURITE,
      token: CashHelper.getData(key:'token')?? ''
    )
    .then((value) {
      favouriteModel = FavouriteModel.fromJson(value.data);
      emit(GetFavouritesSuccess());
    })
    .catchError((error){
      print(error.toString());
      emit(GetFavouritesError());
    })
    ;

  }


  Future <void> postChangeCart({required int id})async{
    emit(ChangeCartLoading());
    await DioHelper.postData(
        end_point: CARTS,
        data: {
          'product_id' : id
        },
        token: CashHelper.getData(key: 'token') ?? ''
    )
        .then((value) {
          if(cart.contains(id)){
            cart.remove(id);
          }
          else{
            cart.add(id);
          }

      changeCartModel = ChangeCartModel.fromJson(value.data);
      emit(ChangeCartSuccess());
    })
        .catchError((error){
      print(error.toString());
      emit(ChangeCartError());
    })
    ;
  }


  Future<void> getCart()async{
    emit(GetCartLoading());
    DioHelper.getData(
        end_point: CARTS,
        token: CashHelper.getData(key:'token')?? ''
    )
        .then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(GetCartSuccess());
    })
        .catchError((error){
      print(error.toString());
      emit(GetCartError());
    })
    ;
  }


  Future <void> postSearch ({required String text})async{
    emit(SearchLoading());
    await DioHelper.postData(
        end_point: SEARCH,
        data: {
          'text' : text
        },
        token: CashHelper.getData(key: 'token') ?? ''
    )
        .then((value) {

      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccess());
    })
        .catchError((error){
      print(error.toString());
      emit(SearchError());
    })
    ;
  }


}
