class OrderModel {
  int status;
  String msg;
  Data data;

  OrderModel({this.status, this.msg, this.data});

  OrderModel.fromJson(Map<String, dynamic> json) {
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
  int allprice;

  Data({this.orders, this.allprice});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = new List<Orders>();
      json['orders'].forEach((v) {
        orders.add(new Orders.fromJson(v));
      });
    }
    allprice = int.tryParse(json['allprice'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    data['allprice'] = this.allprice;
    return data;
  }
}

class Orders {
  int id;
  int amount;
  String code;
  int power;
  String totalPrice;
  List<Product> product;

  Orders(
      {this.id,
      this.amount,
      this.code,
      this.power,
      this.totalPrice,
      this.product});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = int.tryParse(json['amount'].toString());
    code = json['code'];
    power = int.tryParse(json['power'].toString());
    totalPrice = json['total_price'];
    if (json['product'] != null) {
      product = new List<Product>();
      json['product'].forEach((v) {
        product.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['code'] = this.code;
    data['power'] = this.power;
    data['total_price'] = this.totalPrice;
    if (this.product != null) {
      data['product'] = this.product.map((v) => v.toJson()).toList();
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
    price = int.tryParse(json['price'].toString());
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
