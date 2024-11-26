class CategoryModel{
  bool? status;
  String? message;
  Data? data;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data{
  List<MyData>? data;
  num? total;

  Data.fromJson(Map<String, dynamic> json){
    if(json['data'] != null){
      data = <MyData>[];
      json['data'].forEach((v){
        data!.add(new MyData.fromJson(v));
      });
    }

    total = json['total'];
  }
}

class MyData{
  num? id;
  String? name;
  String? image;

  MyData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}