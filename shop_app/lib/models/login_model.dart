class ShopLoginModel {
  bool? status;
  String? message;
  UserData? data;

  ShopLoginModel.fromJson( Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data']!=null ?UserData.fromJson(json: json['data']):null;

  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;

  UserData.fromJson({required Map<String, dynamic> json}) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
  }
}

