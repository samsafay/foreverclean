// import 'package:flutter/material.dart';
// import '../blocs/login_provider.dart';
// import 'package:map_view/map_view.dart';

// class MapScreen extends StatelessWidget {
//   final MapView mapView = MapView();
//   // final CameraPosition cameraPosition;
//   _showMap() {
//     return mapView.show(
//       MapOptions(
//         mapViewType: MapViewType.normal,
//         initialCameraPosition: CameraPosition(
//           Location(43.653225, -79.383186),
//           14.0,
//         ),
//         showUserLocation: true,
//         showMyLocationButton: true,
//         hideToolbar: true,
//       ),
//     );
//   }

//   _box() {
//     return SizedBox(
//       // MaterialButton(
//       //         onPressed: () {
//       //           bloc.signOut();
//       //         },
//       //         minWidth: 200.0,
//       //         child: Text('Sign Out'),
//       //         height: 40.0,
//       //         color: Colors.blue,
//       //       )
//       width: 200.0,
//       height: 200.0,
//       child: Container(
//         color: Colors.yellow,
//       ),
//     );
//   }

//   _positionBox() {
//     return Positioned(
//       right: 20.0,
//       top: 20.0,
//       width: 100.0,
//       height: 100.0,
//       child: Container(
//         color: Colors.indigo,
//       ),
//     );
//   }

//   _getStaticMap() {
//     final StaticMapProvider staticMapViewProvider =
//         StaticMapProvider('AIzaSyDxNdxvjg3ep9NnKmtYuPmtQiF_bvwT5-U');
//     final Uri staticMapUri = staticMapViewProvider.getStaticUriWithMarkers(
//       [Marker('Position', 'Position', 41.40338, 2.17403)],
//       center: Location(41.40338, 2.17403),
//       width: 500,
//       height: 300,
//       maptype: StaticMapViewType.roadmap,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bloc = LoginProvider.of(context);
//     return MaterialApp(
//       title: 'Foreever Clean',
//       home: Scaffold(
//         body: Stack(
//           // alignment: ,
//           children: <Widget>[
//             SizedBox(
//               width: 200.0,
//               height: 200.0,
//               child: _showMap(),
//             ),
//             // _box(),
//             // _positionBox(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import '../blocs/login_provider.dart';
import '../blocs/barcode_provider.dart';
import '../blocs/bar_code_bloc.dart';
import '../services/api.dart';

class MapScreen extends StatelessWidget {
// class MapScreen extends StatelessWidget {
  // final _auth = FirebaseAuth.instance;

  // String final result = "Hey there !";
  // String final qrResult;

  @override
  Widget build(BuildContext context) {
    final bloc = LoginProvider.of(context);
    final blocBarCode = BarCodeProvider.of(context);

    return StreamBuilder(
      stream: bloc.user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _pageWrapper(blocBarCode, bloc, context, snapshot);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  _barCodeTitle(blocBarCode) {
    return StreamBuilder(
      stream: blocBarCode.barCode,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error);
        } else if (!snapshot.hasData) {
          return Text('data 3');
        }
        return Text(snapshot.data);
      },
    );
  }

  Widget _pageWrapper(blocBarCode, bloc, context, snapshot) {
    return new Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.black,
                backgroundImage: NetworkImage(snapshot.data.photoUrl),
              ),
              // child: new Text(snapshot.data.photoUrl),
              accountName: Text(snapshot.data.displayName),
              accountEmail: Text(snapshot.data.email),
            ),
            new ListTile(
              title: new Text("History"),
              trailing: new Icon(Icons.history),
            ),
            new ListTile(
              title: new Text("Payment"),
              trailing: new Icon(Icons.payment),
              onTap: () {
                Navigator.popAndPushNamed(context, '/PaymentScreen');
              },
            ),
            new ListTile(
              title: new Text("Help"),
              trailing: new Icon(Icons.help),
            ),
            new ListTile(
              title: new Text("Settings"),
              trailing: new Icon(Icons.settings),
              onTap: () {
                Navigator.popAndPushNamed(context, '/SettingsScreen');
              },
            ),
            new Divider(),
            new ListTile(
              title: new Text("Sign Out"),
              trailing: new Icon(Icons.close),
              onTap: bloc.signOut,
            )
          ],
        ),
      ),
      appBar: AppBar(
        // title: _barCodeTitle(blocBarCode),
        title: _barCodeTitle(blocBarCode),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(43.653225, -79.383186),
              minZoom: 11.0,
            ),
            layers: [
              TileLayerOptions(
                additionalOptions: {
                  'accessToken': MAPBOX_API,
                  'id': 'mapbox.streets',
                },
                urlTemplate: "https://api.mapbox.com/v4/"
                    "{id}/{z}/{x}/{y}@2x.png?access_token=${MAPBOX_API}",
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 45.0,
                    height: 45.0,
                    point: LatLng(43.653225, -79.383186),
                    builder: (context) => Container(
                      child: IconButton(
                        icon: Icon(Icons.location_on),
                        color: Colors.red,
                        iconSize: 45.0,
                        onPressed: () async {
                          print(snapshot.data);
                        },
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.crop_free),
        label: Text("UNLOCK"),
        // onPressed: () {},
        onPressed: blocBarCode.scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
