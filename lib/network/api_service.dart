import 'dart:convert';
import 'dart:io';

import 'package:weather_map/model/weather_response.dart';
import 'package:weather_map/network/api_exception.dart';
import 'package:weather_map/network/constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  ApiService._();

  static final ApiService api = ApiService._();

  Future<WeatherResponse> fetchWeather() async {
    Uri url = Uri.parse('$baseUrl$endPoint');
    try {
      http.Response response = await http.get(url);
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        return WeatherResponse.fromJson(jsonData);
      } else {
        throw ApiException.fromJson(jsonData);
      }
    } on HttpException catch (e) {
      throw ApiException(0, e.message);
    }
  }
}
