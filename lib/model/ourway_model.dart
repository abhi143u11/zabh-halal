class OurWayModel {
  int status;
  String msg;
  Data data;

  OurWayModel({this.status, this.msg, this.data});

  OurWayModel.fromJson(Map<String, dynamic> json) {
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
  List<Ourways> ourways;

  Data({this.ourways});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['ourways'] != null) {
      ourways = new List<Ourways>();
      json['ourways'].forEach((v) {
        ourways.add(new Ourways.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ourways != null) {
      data['ourways'] = this.ourways.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ourways {
  int id;
  String address;
  String lat;
  String lng;
  String createdAt;
  String updatedAt;

  Ourways(
      {this.id,
      this.address,
      this.lat,
      this.lng,
      this.createdAt,
      this.updatedAt});

  Ourways.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
