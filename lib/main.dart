import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/screens/place_list.dart';
import '/screens/add_place.dart';
import '/screens/place_detail.dart';
import '/providers/places.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Places()),
      ],
      child: MaterialApp(
        // showPerformanceOverlay: true,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.indigo,
            // ignore: deprecated_member_use
            accentColor: Colors.amber),
        themeMode: ThemeMode.dark,
        home: const PlaceListScreen(),
        routes: {
          AddPlaceScreen.routeName: (context) => const AddPlaceScreen(),
          PlaceDetailScreen.routeName: (context) => const PlaceDetailScreen(),
        },
      ),
    );
  }
}
