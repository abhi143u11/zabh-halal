import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zabh_halal/model/payment_model.dart';
import 'package:zabh_halal/resources/base_scoped_model.dart';
import 'package:zabh_halal/utilities/helper_widgets.dart';
import 'package:zabh_halal/ui/tabs/1-main_page/subPages/done_payment.dart';
import 'package:zabh_halal/utilities/colors.dart';

class ConfirmPayment extends StatefulWidget {
  final String id;
  final String name;
  final String phon;

  const ConfirmPayment({Key key, this.id, this.name, this.phon})
      : super(key: key);
  @override
  _ConfirmPaymentState createState() => _ConfirmPaymentState();
}

class _ConfirmPaymentState extends State<ConfirmPayment> {
  File _image;
  Future getImage() async {
    return await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  bool isLoading = false;
  startLoading() {
    isLoading = true;
    setState(() {});
  }
  stopLoading() {
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
              child: TextD(
                title: 'الشراء',
                fontSize: 22,
                textColor: Colors.white,
                height: 0.8,
              ),
            )
          ],
        ),
        body: LoadablePage(
          isLoading: isLoading,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      getImage().then((image) {
                        _image = image;
                        setState(() {});
                      });
                    },
                    child: _image == null
                        ? DottedBorder(
                            strokeCap: StrokeCap.round,
                            borderType: BorderType.RRect,
                            strokeWidth: 3,
                            dashPattern: [6],
                            color: Colors.grey,
                            radius: Radius.circular(12),
                            child: Container(
                              height: 300,
                              width: 300,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.add_a_photo,
                                      size: 35,
                                      color: Colors.grey,
                                    ),
                                    TextD(
                                      title: 'أرفق صورة الوصل',
                                      fontSize: 16,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Image.file(_image,height: MediaQuery.of(context).size.height*0.7,fit: BoxFit.contain,),
                  ),
                  ScopedModelDescendant<BaseModel>(
                      builder: (context, child, model) {
                    return FutureBuilder<PaymentModel>(
                        // future: model.confirmPayment(context, 'hamdy', '010021354564', 'orderID', _image),
                        builder: (context, snapshot) {
                      // if(snapshot.hasError || snapshot.data == null)
                      // return Container();
                      // else
                      return ClippedButton(
                        color: ColorsD.redDefault,
                        onTapCallback: isLoading? null:() {
                          if (_image == null)
                            AlertDialogs.failed(context,
                                content: 'من فضلك ارفق الصورة');
                          else {
                            startLoading();
                            model
                                .confirmPayment(context, '${widget.name}',
                                    '${widget.phon}', '${widget.id}', _image)
                                .then((data) {
                              print(data);
                              stopLoading();
                              (data as StreamSubscription).onData((d) {
                                final model =
                                    PaymentModel.fromJson(json.decode(d));
                                print(data);
                                if (data != null)
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DonePayment(
                                                orderID: model
                                                    .data.payment.orderId
                                                    .toString(),
                                              )));
                              });
                            });
                          }
                        },
                        child: TextD(
                          title: 'إرسال طلب',
                          textColor: Colors.white,
                          fontSize: 18,
                        ),
                      );
                    });
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
