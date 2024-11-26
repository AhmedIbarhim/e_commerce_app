import 'package:flutter/cupertino.dart';

class HomeModel{
  bool? status;
  String? message;
  Data? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data']!= null? new Data.fromJson(json['data']) : null;
  }
}

class Data{
  List <Banners>? banners;
  List <Products>? products;
  List <Products> sales = [];
  String? ad;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null){
      banners = <Banners>[];
      json['banners'].forEach((v){
        banners!.add(new Banners.fromJson(v));
      });
    }
    if (json['products'] != null){
      products = <Products>[];
      json['products'].forEach((v){
        Products product = Products.fromJson(v);
        if(product.discount != 0){
          sales!.add(product);
        }
        products!.add(product);
      });
    }
    ad = json['ad'];
  }
}

class Banners{
  int? id;
  String? image;

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class Products{
  int? id;
  num? price;
  num? oldPrice;
  num? discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavourites;
  bool? inCart;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images']!= null? new List<String>.from(json['images']) : null;
    inFavourites = json['in_favorites'];
    inCart = json['in_cart'];
  }

}
