import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zabh_halal/model/banks_model.dart';
import 'package:zabh_halal/resources/base_scoped_model.dart';
import 'package:zabh_halal/utilities/apis.dart';
import 'package:zabh_halal/utilities/colors.dart';

class BankAccounts extends StatefulWidget {
  @override
  _BankAccountsState createState() => _BankAccountsState();
}

class _BankAccountsState extends State<BankAccounts> {
  Future<BanksModel> _future;
  @override
  void initState() {
    _future = baseModel.getBankInfo(context).then((x) {
      _snapshot = x;
    });
    // TODO: implement initState
    super.initState();
  }

  BanksModel _snapshot;
  @override
  Widget build(BuildContext context) {
    return ScopedModel<BaseModel>(
      model: baseModel,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
              child: TextD(
                textColor: Colors.white,
                title: "حسباتنا",
                fontSize: 18,
              ),
            ),
          ],
        ),
        body: ScopedModelDescendant<BaseModel>(
            rebuildOnChange: true,
            builder: (context, child, model) {
              return FutureBuilder<BanksModel>(
                  future: _future,
                  initialData: null,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(
                          child: Loading(
                        indicator: BallPulseIndicator(),
                        color: ColorsD.redDefault,
                      ));
                    if (_snapshot != null)
                      return ListView(
                        shrinkWrap: true,
                        children:
                            List.generate(_snapshot.data.banks.length, (index) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(color: Colors.grey, blurRadius: 4)
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Image.network(
                                    '${Apis.imageUrl}${_snapshot.data.banks[index].image}',
                                    fit: BoxFit.cover,
                                  ),

                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        TextD(
                                          title:
                                              'بنك ${_snapshot.data.banks[index].bankName}',
                                          textColor: Colors.blue[600],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.dotCircle,
                                          color: Colors.blue[600],
                                        ),
                                      ],
                                    ),
                                  ),

                                  Divider(),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextD(
                                      title:
                                          'إسم المستفيد: ${_snapshot.data.banks[index].ownerName}',
                                      fontSize: 14,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextD(
                                      title:
                                          'رقم الحساب: ${_snapshot.data.banks[index].number}',
                                      fontSize: 14,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextD(
                                      title:
                                          'رقم الايبان: ${_snapshot.data.banks[index].iban}',
                                      fontSize: 14,
                                    ),
                                  ),
                                  // Divider(),
                                  // Align(
                                  //   child: TextD(
                                  //     title:
                                  //         snapshot.data.data.banks[index].ownerName,
                                  //     textColor: ColorsD.redDefault,
                                  //     fontSize: 16,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          );
                        }),
                      );

                    return GestureDetector(
                      onTap: () {
                        _future = model.getBankInfo(context).then((x) {
                          _snapshot = x;
                          Future.delayed(
                              Duration(seconds: 1), () => setState(() {}));
                        });
                      },
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              (Icons.refresh),
                              size: 55,
                              color: Colors.grey,
                            ),
                            TextD(
                              title: 'فشل الاتصال',
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }

  Future getBanks() {}
}
