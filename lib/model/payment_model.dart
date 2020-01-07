class   PaymentModel {
  int status;
  String msg;
  Data data;

  PaymentModel({this.status, this.msg, this.data});

  PaymentModel.fromJson(Map<String, dynamic> json) {
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
  Payment payment;

  Data({this.payment});

  Data.fromJson(Map<String, dynamic> json) {
    payment =
        json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.payment != null) {
      data['payment'] = this.payment.toJson();
    }
    return data;
  }
}

class Payment {
  String orderId;
  int userId;
  String image;
  String updatedAt;
  String createdAt;
  int id;

  Payment(
      {this.orderId,
      this.userId,
      this.image,
      this.updatedAt,
      this.createdAt,
      this.id});

  Payment.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    userId = json['user_id'];
    image = json['image'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['user_id'] = this.userId;
    data['image'] = this.image;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
