class SettingsModel {
  int status;
  String msg;
  Data data;

  SettingsModel({this.status, this.msg, this.data});

  SettingsModel.fromJson(Map<String, dynamic> json) {
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
  Settings settings;
  List<Contacts> contacts;

  Data({this.settings, this.contacts});

  Data.fromJson(Map<String, dynamic> json) {
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
    if (json['contacts'] != null) {
      contacts = new List<Contacts>();
      json['contacts'].forEach((v) {
        contacts.add(new Contacts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.settings != null) {
      data['settings'] = this.settings.toJson();
    }
    if (this.contacts != null) {
      data['contacts'] = this.contacts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Settings {
  int id;
  String appName;
  String file;
  String policy;
  String myWay;
  String facebook;
  String whatsapp;
  String instgram;
  String twitter;
  String gmail;
  String createdAt;
  String updatedAt;

  Settings(
      {this.id,
      this.appName,
      this.file,
      this.policy,
      this.myWay,
      this.facebook,
      this.whatsapp,
      this.instgram,
      this.twitter,
      this.gmail,
      this.createdAt,
      this.updatedAt});

  Settings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appName = json['app_name'];
    file = json['file'];
    policy = json['policy'];
    myWay = json['my_way'];
    facebook = json['facebook'];
    whatsapp = json['whatsapp'];
    instgram = json['instgram'];
    twitter = json['twitter'];
    gmail = json['gmail'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['app_name'] = this.appName;
    data['file'] = this.file;
    data['policy'] = this.policy;
    data['my_way'] = this.myWay;
    data['facebook'] = this.facebook;
    data['whatsapp'] = this.whatsapp;
    data['instgram'] = this.instgram;
    data['twitter'] = this.twitter;
    data['gmail'] = this.gmail;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Contacts {
  int id;
  String contact;
  String createdAt;
  String updatedAt;

  Contacts({this.id, this.contact, this.createdAt, this.updatedAt});

  Contacts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contact = json['contact'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['contact'] = this.contact;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
