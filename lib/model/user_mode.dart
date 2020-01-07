class UserModel {
  String msg;
  int smsCode;
  UserData data;

  UserModel({this.msg, this.smsCode, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    smsCode = json['sms_code'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['sms_code'] = this.smsCode;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class UserData {
  String apiToken;
  int id;
  String phone;

  UserData({this.apiToken, this.id, this.phone});

  UserData.fromJson(Map<String, dynamic> json) {
    apiToken = json['api_token'];
    id = json['id'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() { 
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_token'] = this.apiToken;
    data['id'] = this.id;
    data['phone'] = this.phone;
    return data;
  }
}
