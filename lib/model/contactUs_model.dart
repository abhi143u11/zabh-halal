class ContactModel {
  int status;
  String msg;
  List<Data> data;

  ContactModel({this.status, this.msg, this.data});

  ContactModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String gmail;
  String whatsapp;

  Data({this.gmail, this.whatsapp});

  Data.fromJson(Map<String, dynamic> json) {
    gmail = json['gmail'];
    whatsapp = json['whatsapp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gmail'] = this.gmail;
    data['whatsapp'] = this.whatsapp;
    return data;
  }
}