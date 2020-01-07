import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zabh_halal/model/allProducts_model.dart';
import 'package:zabh_halal/model/user_mode.dart';
import 'package:zabh_halal/resources/app_info.dart';
import 'package:zabh_halal/resources/auth.dart';
import 'package:zabh_halal/resources/product.dart';

class BaseModel extends Model with Auth, AppInfo, ProductModel {
  static bool isLoading = false;
  List allProducts = [];
  BaseModel() {
    checkAuth();
    print('object');
  }
  bool isAuth ;
  List<Services> services;
  List<Cut> cuts;
  List<Packaging> packaging;
  UserModel userData;
  Future checkAuth() async {
    SharedPreferences.getInstance().then((pref){
      isAuth =  (pref.get('userData')) != null;
      if(isAuth)
      {
      print(isAuth);
        userData = UserModel.fromJson(json.decode((pref.get('userData'))));}
        // print(userData.data.apiToken);
        allProducts =pref.get('products')==null? allProducts: json.decode(pref.get('products'))?? [];
    });
    
  }
}

 BaseModel baseModel;
