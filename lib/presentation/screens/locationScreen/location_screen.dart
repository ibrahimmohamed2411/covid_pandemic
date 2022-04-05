import 'package:covid_pandemic/core/constants/state_to_iso.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {},
          child: Text('get Location'),
        ),
      ),
    );
  }

  static Future<String?> getCurrentState() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      await Geolocator.requestPermission();
    }
    var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> list =
        await GeocodingPlatform.instance.placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (list.first.administrativeArea!.length > 2) {
      var state = StateToIso.states[list.first.administrativeArea];
      return state;
    }
    return list.first.administrativeArea;
  }
}
// 37.785834
// -122.406417
