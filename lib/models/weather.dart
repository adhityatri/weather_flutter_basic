class Weather {
  final double? temp;
  final double? feelsLike;
  final double? low;
  final double? high;
  final String city;

  Weather({this.temp, this.feelsLike, this.low, this.high, required this.city});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      low: json['main']['temp_min'].toDouble(),
      high: json['main']['temp_max'].toDouble(),
      city: json['name'],
    );
  }
}
