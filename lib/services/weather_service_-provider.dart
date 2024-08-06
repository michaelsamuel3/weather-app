// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather/models/weather_response.dart';
import 'package:weather/pages/secrets/api.dart';
import 'package:http/http.dart ' as http;

class WeatherServiceprovider extends ChangeNotifier {
  WeatherModel? _weather;
  WeatherModel? get weather => _weather;

  bool _isloading = false;
  bool get isloading => _isloading;

  String _error = "";
  String get error => _error;

  Future<void> fetchWeatherDataByCity(String city) async {
    _isloading = true;
    _error = "";

    try {
      final String apiUrl =
          "${APIendPoints().cityUrl}${city}&appid=${APIendPoints().apikey}${APIendPoints().unit}";
      print(apiUrl);
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        _weather = WeatherModel.fromJson(data);
        print(_weather);
        notifyListeners();
      } else {
        _error = "failed to load data";
      }
    } catch (e) {
      _error = "failed to load data $e";
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }
}
