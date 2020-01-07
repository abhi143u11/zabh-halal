class AllProductsModel {
  int status;
  String msg;
  Data data;

  AllProductsModel({this.status, this.msg, this.data});

  AllProductsModel.fromJson(Map<String, dynamic> json) {
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
  List<Services> services;
  List<Cut> cut;
  List<Packaging> packaging;
  List<Ads> ads;

  Data({this.services, this.cut, this.packaging, this.ads});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = new List<Services>();
      json['services'].forEach((v) {
        services.add(new Services.fromJson(v));
      });
    }
    if (json['cut'] != null) {
      cut = new List<Cut>();
      json['cut'].forEach((v) {
        cut.add(new Cut.fromJson(v));
      });
    }
    if (json['Packaging'] != null) {
      packaging = new List<Packaging>();
      json['Packaging'].forEach((v) {
        packaging.add(new Packaging.fromJson(v));
      });
    }
    if (json['ads'] != null) {
      ads = new List<Ads>();
      json['ads'].forEach((v) {
        ads.add(new Ads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    if (this.cut != null) {
      data['cut'] = this.cut.map((v) => v.toJson()).toList();
    }
    if (this.packaging != null) {
      data['Packaging'] = this.packaging.map((v) => v.toJson()).toList();
    }
    if (this.ads != null) {
      data['ads'] = this.ads.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int id;
  String name;
  String path;
  Null details;
  String createdAt;
  String updatedAt;
  List<Products> products;

  Services(
      {this.id,
      this.name,
      this.path,
      this.details,
      this.createdAt,
      this.updatedAt,
      this.products});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    path = json['path'];
    details = json['details'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['path'] = this.path;
    data['details'] = this.details;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int id;
  String name;
  String price;
  Null offer;
  Null status;
  String image;
  String serviceId;
  String createdAt;
  String updatedAt;

  Products(
      {this.id,
      this.name,
      this.price,
      this.offer,
      this.status,
      this.image,
      this.serviceId,
      this.createdAt,
      this.updatedAt});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    offer = json['offer'];
    status = json['status'];
    image = json['image'];
    serviceId = json['service_id'];
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
    data['image'] = this.image;
    data['service_id'] = this.serviceId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Cut {
  int id;
  String name;
  String image;

  Cut({this.id, this.name, this.image});

  Cut.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class Packaging {
  int id;
  String name;
  String createdAt;
  String updatedAt;

  Packaging({this.id, this.name, this.createdAt, this.updatedAt});

  Packaging.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Ads {
  int id;
  String ad;
  String createdAt;
  String updatedAt;

  Ads({this.id, this.ad, this.createdAt, this.updatedAt});

  Ads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ad = json['ad'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ad'] = this.ad;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
