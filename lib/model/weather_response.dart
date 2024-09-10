class WeatherResponse {
  List<Weather> weather = [];
  MainWeather? mainWeather;

  WeatherResponse(this.weather, this.mainWeather);

  WeatherResponse.fromJson(Map<String, dynamic> json) {
    json['weather'].forEach((e) => weather.add(Weather.fromJson(e)));
    mainWeather = MainWeather.fromJson(json['main']);
  }
}

class Weather {
  String description;
  String icon;

  Weather(this.description, this.icon);

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(json['description'], json['icon']);
  }
}

class MainWeather {
  int temp;

  MainWeather(this.temp);

  factory MainWeather.fromJson(Map<String, dynamic> json) {
    return MainWeather(json['temp'].toInt());
  }
}
