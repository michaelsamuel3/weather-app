 import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/root.dart';
import 'package:weather/services/location_provider.dart';
import 'package:weather/services/weather_service_-provider.dart';
// import 'package:weather/root.dart';


void main(List<String> args) {
  runApp(MultiProvider(
     providers: [
        ChangeNotifierProvider(create:(context) => LocationProvider(),),
        ChangeNotifierProvider(create:(context) => WeatherServiceprovider(),),
        
      ],
    child: const Root()));
}

