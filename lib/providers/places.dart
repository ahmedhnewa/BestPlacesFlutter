import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/models/place.dart';
import '/helpers/db_helper.dart';

class Places with ChangeNotifier {
  final List<Place> _items = [];
  static const tableName = 'user_places';

  List<Place> get items => [..._items];

  bool get isEmpty => _items.isEmpty;

  int get itemCount => _items.length;

  void addPlace(String title, File pickedImage, LocationPlace locationPlace) {
    final place = Place(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      location: locationPlace,
      image: pickedImage,
    );
    _items.add(place);
    notifyListeners();
    DBHelper.insert(tableName, {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
      'location': json.encode(locationPlace.toMap())
    });
  }

  Future<void> fetchPlaces() async {
    final dataList = await DBHelper.getData(tableName);
    final places = dataList
        .map((e) => Place(
              id: e['id'],
              title: e['title'],
              location: LocationPlace.fromMap(json.decode(e['location'])),
              image: File(e['image']),
            ))
        .toList();
    _items.clear();
    _items.addAll(places);
    notifyListeners();
  }
}
