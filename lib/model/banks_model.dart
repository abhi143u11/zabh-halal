class BanksModel {
  int status;
  String msg;
  Data data;

  BanksModel({this.status, this.msg, this.data});

  BanksModel.fromJson(Map<String, dynamic> json) {
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
  List<Banks> banks;

  Data({this.banks});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['banks'] != null) {
      banks = new List<Banks>();
      json['banks'].forEach((v) {
        banks.add(new Banks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banks != null) {
      data['banks'] = this.banks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banks {
  int id;
  String bankName;
  String number;
  String iban;
  String ownerName;
  String phone;
  String image;
  String createdAt;
  String updatedAt;

  Banks(
      {this.id,
      this.bankName,
      this.number,
      this.iban,
      this.ownerName,
      this.phone,
      this.image,
      this.createdAt,
      this.updatedAt});

  Banks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankName = json['bank_name'];
    number = json['number'];
    iban = json['iban'];
    ownerName = json['owner_name'];
    phone = json['phone'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank_name'] = this.bankName;
    data['number'] = this.number;
    data['iban'] = this.iban;
    data['owner_name'] = this.ownerName;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
