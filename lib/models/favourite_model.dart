class FavouriteModel {
  bool? status;
  dynamic message;
  Data? data;

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {

  List<Details>? details;
  int? total;




  Data.fromJson(Map<String, dynamic> json) {

    if (json['data'] != null) {
      total = json['total'];
      details = <Details>[];
      json['data'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }

  }

}

class Details {
  int? id;
  Product? product;

  Details({this.id, this.product});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;



  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}