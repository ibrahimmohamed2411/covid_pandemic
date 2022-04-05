import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:covid_pandemic/core/constants/state_to_iso.dart';
import 'package:covid_pandemic/logic/cubit/statistics/statistics_cubit.dart';
import 'package:covid_pandemic/presentation/screens/questions/question_screen.dart';
import 'package:covid_pandemic/presentation/screens/statistics/statistics_screen.dart';
import 'package:covid_pandemic/presentation/widgets/drawer.dart';

import '../health/health_screen.dart';
import '../home/home_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    String? state = await getCurrentState();
    BlocProvider.of<StatisticsCubit>(context).initialize(stateCode: state!);
  }

  final List _screens = [
    const HomeScreen(),
    StatsScreen(),
    const HealthScreen(),
    const QuestionsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      drawer: const DrawerWidget(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        elevation: 0.0,
        items: [
          Icons.home,
          Icons.insert_chart,
          Icons.event_note,
          Icons.info,
        ]
            .asMap()
            .map((key, value) => MapEntry(
                  key,
                  BottomNavigationBarItem(
                    label: '',
                    icon: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                        color: _currentIndex == key
                            ? Colors.blue[600]
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Icon(value),
                    ),
                  ),
                ))
            .values
            .toList(),
      ),
    );
  }

  Future<String?> getCurrentState() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      await Geolocator.requestPermission();
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
    }
    if (permission == LocationPermission.denied) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
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
    var state = list.first.administrativeArea;
    return state;
  }
}
