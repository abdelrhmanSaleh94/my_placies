import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/great_places.dart';
import './screen/place_list_screen.dart';
import './screen/add_place_screen.dart';
import './screen/detail_place_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'My Palcies',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PlaceList(),
        routes: {
          AddPlace.routeName: (ctx) => AddPlace(),
          PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
