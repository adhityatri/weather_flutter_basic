import 'dart:convert';
import 'package:flutter/material.dart';
import 'models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot != null) {
                if (snapshot.data == null) {
                  return Text('Error Getting Weater');
                } else {
                  Weather _weather = snapshot.data;
                  return WeatherBox(_weather);
                }
              } else {
                return CircularProgressIndicator();
              }
            },
            future: getCurrentWeather(),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget WeatherBox(Weather weather) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(10.0),
          child: Text(
            "${weather.temp}°C",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
          ),
        ),
        Container(
          child: Text(
            weather.city,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
          ),
        ),
        // Text(weather.description),
        // Text("Feels:${weather.feelsLike}° C"),
        // Text("H:${weather.temp}°C L:${weather.low}°C"),
      ],
    );
  }

  Future getCurrentWeather() async {
    Weather? weather;
    String city = "jember";
    String apiKey = "d9de3d7bf210e7a3c1b4a45a07c49889";
    var url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body));
    } else {}

    return weather;
  }
}
