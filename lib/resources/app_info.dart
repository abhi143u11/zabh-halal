// import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:zabh_halal/model/banks_model.dart';
import 'package:zabh_halal/model/contactUs_model.dart';
import 'package:zabh_halal/model/ourway_model.dart';
import 'package:zabh_halal/model/question_model.dart';
import 'package:zabh_halal/model/settings_nodel.dart';
import 'package:zabh_halal/resources/base_scoped_model.dart';
import 'package:zabh_halal/utilities/apis.dart';
import 'package:zabh_halal/utilities/helper_widgets.dart';

mixin AppInfo on Model {
  // bool _isLoading = false;
  // bool get isLoading => _isLoading;

  showLoading() {
    BaseModel.isLoading = true;
    notifyListeners();
  }

  stopLoading() {
    BaseModel.isLoading = false;
    notifyListeners();
  }

  Future answerQuestion(BuildContext context, String reply) async {
    final response = await Apis.postRequest(
        context, '${Apis.baseUrl}storequestion', baseModel.userData==null? '':baseModel.userData.data.apiToken, {
      "reply": reply,
      "question_id": questionID,
    });
    // if (response != null)
      // AlertDialogs.success(context, content: 'نشكركم على ابداء رأيكم');
  }

  String questionID;
  Future<QuestionModel> getQuestion(BuildContext context) async {
    final response = await Apis.getRequest(context, '${Apis.baseUrl}question',
        token: baseModel.userData ==null?'': baseModel.userData.data.apiToken);
    if (response != null) {
      questionID = QuestionModel.fromJson(response).data.products.id.toString();

      return QuestionModel.fromJson(response);
    }
  }

  Future<OurWayModel> getMarkers(BuildContext context) async {
    final response = await Apis.getRequest(context, '${Apis.baseUrl}ourways');
    if (response != null) return OurWayModel.fromJson(response);
  }

  Future<SettingsModel> getContactInfo(BuildContext context) async {
    showLoading();
    final response = await Apis.getRequest(context, '${Apis.baseUrl}howshoping');
    if (response != null) {
      stopLoading();
      return SettingsModel.fromJson(response);
    }
    stopLoading();
  }

  Future<BanksModel> getBankInfo(BuildContext context) async {
    final response = await Apis.getRequest(context, "${Apis.baseUrl}banks");
    if (response != null)
      {
        return BanksModel.fromJson(response);}
    else
      throw Error();
  }
}
