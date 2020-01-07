import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zabh_halal/model/ourway_model.dart';
// import 'package:simple_permissions/simple_permissions.dart';
import 'package:zabh_halal/resources/base_scoped_model.dart';
import 'package:zabh_halal/utillities.dart';
import 'package:zabh_halal/utilities/colors.dart';
import 'package:zabh_halal/utilities/helper_widgets.dart';

class AccountsPage extends StatefulWidget {
  @override
  _AccountsPageState createState() => _AccountsPageState();
}

List<Ourways> ways = [];

// Position pos;
class _AccountsPageState extends State<AccountsPage> with AutomaticKeepAliveClientMixin{
  @override
  void initState() {
    // Geolocator locator = Geolocator();
    // locator.getCurrentPosition().then((position){
    // pos =position;
    // });
    getLocation();
    baseModel.getMarkers(context).then((model) {
      if (model != null)
        model.data.ourways.forEach((mark) {
          ways = model.data.ourways;
          marker.add(Marker(
              markerId: MarkerId(mark.id.toString()),
              position:
                  LatLng(double.tryParse(mark.lat), double.tryParse(mark.lng)),
              infoWindow: InfoWindow(title: mark.address)));
        });
      setState(() {});
    });
    super.initState();
  }

  getLocation() async {
    // final x = await PermissionH
  }

  
  dynamic addres;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
              child: TextD(
                title: 'طريقنا',
                fontSize: 22,
                textColor: Colors.white,
                height: 0.8,
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            ClippedButton(
                color: Colors.white,
                onTapCallback: null,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                                  child: DropdownButton(
                    hint: TextD(
                        textColor: ColorsD.redDefault, title: 'إختر أحد فروعنا'),
                    value: addres,
                    onChanged: (s) async{
                      addres = s;
                      setState(() {});
                              GoogleMapController ctrler = await completer.future;
                            
                              ctrler.animateCamera(CameraUpdate.newLatLngZoom(
                                  LatLng(
                                      double.tryParse(ways.singleWhere((way)=>way.address==s.toString()).lat.toString()),
                                      double.tryParse(ways.singleWhere((way)=>way.address==s.toString()).lng.toString())),
                                  15));
                    },
                    items: List.generate(ways.length, (index) {
                      return DropdownMenuItem(
                          child: Container(
                            // onTap: () async {
                            // },
                            child: TextD(
                              textColor: ColorsD.redDefault,
                              title: '${ways[index].address}',
                            ),
                          ),
                          value: '${ways[index].address}');
                    }),
                  ),
                )),
            Expanded(
              child: Center(
                child: GoogleMap(
                  markers: marker,
                  initialCameraPosition: CameraPosition(target: LatLng(0, 0)),
                  onMapCreated: _onMapCreated,
                ),
              ),
            ),
          ],
        ));
  }

// GoogleMapController controller = await GoogleMapController.init();
  Set<Marker> marker = Set.of([
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(0, 0),
    )
  ]);
  Completer<GoogleMapController> completer = Completer();
  _onMapCreated(GoogleMapController s) {
    // Geolocator locator = Geolocator();
    // locator.getCurrentPosition().then((position){
    //   pos =position;
    // s.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(pos.latitude, pos.longitude))));
    // marker.add(Marker(position: LatLng(pos.l/atitude,pos.longitude), markerId: MarkerId(marker.length.toString())));
    completer.complete(s);
    // });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
