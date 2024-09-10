import 'package:weather_map/model/weather_response.dart';
import 'package:weather_map/network/api_service.dart';
import 'package:weather_map/network/constants.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Information'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: FutureBuilder<WeatherResponse>(
          future: ApiService.api.fetchWeather(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Weather> weather = snapshot.data!.weather;
              MainWeather? mainWeather = snapshot.data!.mainWeather;
              return ListView.builder(
                itemCount: weather.length,
                itemBuilder: (context, index) => Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading:
                        Image.network('$iconImg${weather[index].icon}@2x.png'),
                    title: Text(
                      weather[index].description,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${mainWeather!.temp}°C',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
