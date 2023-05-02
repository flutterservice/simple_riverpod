import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

enum City { dhaka, khulna, sylhet }

typedef WeatherEmoji = String;

Future<WeatherEmoji> getWeather(City city) {
  return Future.delayed(const Duration(seconds: 1),
      () => {City.dhaka: '🌦️', City.khulna: '🌻', City.sylhet: "🌧️"}[city]!);
}

//UI write this
final currentCityProvider = StateProvider<City?>((ref) {
  return null;
});

const unknownWeatherEmoji = "😑";

//UI read this
final weatherProvider = FutureProvider<WeatherEmoji>((ref) {
  final city = ref.watch(currentCityProvider);
  if (city != null) {
    return getWeather(city);
  } else {
    return unknownWeatherEmoji;
  }
});

class HomePage extends ConsumerWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(weatherProvider);
    return Scaffold(
        appBar: AppBar(title: Text("Home")),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: City.values.length,
                    itemBuilder: (context, index) {}))
          ],
        ));
  }
}

// Important:  min 1:18:00
