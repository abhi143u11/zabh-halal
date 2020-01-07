class CartModel {
  int status;
  String msg;
  Data data;

  CartModel({this.status, this.msg, this.data});

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<Orders> orders;

  Data({this.orders});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = new List<Orders>();
      json['orders'].forEach((v) {
        orders.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  int id;
  String amount;
  int totalPrice;
  Product product;

  Orders({this.id, this.amount, this.totalPrice, this.product});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['qty'];
    totalPrice = json['total_price'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['qty'] = this.amount;
    data['total_price'] = this.totalPrice;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

class Product {
  int id;
  String name;
  int price;
  String offer;
  String status;
  int serviceId;
  String image;
  String createdAt;
  String updatedAt;

  Product(
      {this.id,
      this.name,
      this.price,
      this.offer,
      this.status,
      this.serviceId,
      this.image,
      this.createdAt,
      this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = int.parse(json['price'].toString());
    offer = json['offer'];
    status = json['status'];
    serviceId = int.tryParse(json['service_id'].toString());
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['offer'] = this.offer;
    data['status'] = this.status;
    data['service_id'] = this.serviceId;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
