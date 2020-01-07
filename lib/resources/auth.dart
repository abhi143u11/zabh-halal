import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zabh_halal/model/user_mode.dart';
import 'package:zabh_halal/resources/base_scoped_model.dart';
import 'package:zabh_halal/utilities/apis.dart';
import 'package:zabh_halal/utilities/colors.dart';
import 'package:zabh_halal/utilities/helper_widgets.dart';

mixin Auth on Model {
  startLoading() {
    BaseModel.isLoading = true;
    notifyListeners();
  }

  stopLoading() {
    BaseModel.isLoading = false;
    notifyListeners();
  }

  // bool get isLoading => _isLoading;
  // bool _isLoading = false;
  Future<UserModel> login(BuildContext context, String phone) async {
    final response = await http.post(
      '${Apis.baseUrl}login',
      body: {"phone": phone},
      // headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['msg'] == 'success') {
        baseModel.userData = UserModel.fromJson(responseData);
        final pref = await SharedPreferences.getInstance();
        pref.clear();
        pref.setString('userData', json.encode(baseModel.userData.toJson()));
        
        await baseModel.checkAuth();
        return baseModel.userData;
      } else
        return await register(phone, context);
    } else
      AlertDialogs.failed(context, content: 'تعذر الإتصال');
  }

  UserModel tempUserData;
  Future<UserModel> register(String phonenumber, BuildContext context) async {
    startLoading();
    final response = await http.post(
      "${Apis.baseUrl}register",
      body: {'phone': phonenumber},
      headers: {
        "Accept": "application/json",
        // "Content-Type": "application/json",
      },
    );
    stopLoading();
    if (response.statusCode >= 200 || response.statusCode <= 300) {
      final Map responseData = json.decode(response.body);
      print(responseData);
      final userModel = UserModel.fromJson(responseData);
      if (userModel.msg == 'failed') {
        AlertDialogs.failed(context, content: responseData['data']['msg']);
      } else {
        print('error $responseData');
        baseModel.userData = UserModel.fromJson(responseData);
        final pref = await SharedPreferences.getInstance();
        pref.setString('userData', json.encode(baseModel.userData.toJson()));
        await baseModel.checkAuth();
        return userModel;
      }
    } else {
      AlertDialogs.failed(context, content: 'تعذر الإتصال');
    }
  }

  Future verifyCode(context, String enteredCode) async {
    final pref = await SharedPreferences.getInstance();
    if (enteredCode == tempUserData.smsCode.toString()) {
      pref.setString('userData', json.encode(tempUserData));
      return true;
    } else
      AlertDialogs.failed(context,
          content: 'كود التفعيل غير صحيح, اعد المحاولة');
  }
}
