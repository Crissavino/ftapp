import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class LocationRepository {
  final String _accessToken = 'pk.eyJ1IjoiY3Jpc3NhdmlubyIsImEiOiJja2R4OXk4YmQyemUwMnl0YXBtb2psc2tiIn0.P857CLf3OM5PRBPL7IPHbw';
  String _searchLatLongUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places';


  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future getUserLocationDataFromMapBox({double lat, double long, String query}) async {
    String searchLatLongInMapBox = '$_searchLatLongUrl/$long%2C$lat.json?access_token=$_accessToken&cachebuster=1610899994718&autocomplete=false';
    String ap = 'https://api.mapbox.com/geocoding/v5/mapbox.places/-122.16556763702022%2C37.44458152057953.json?access_token=pk.eyJ1Ijoic2VhcmNoLW1hY2hpbmUtdXNlci0xIiwiYSI6ImNrN2Y1Nmp4YjB3aG4zZ253YnJoY21kbzkifQ.JM5ZeqwEEm-Tonrk5wOOMw&cachebuster=1610899994718&autocomplete=false';
    print(ap);
    final res = await http.get(
      ap,
    );

    final body = json.decode(res.body);

    return body;

  }

}