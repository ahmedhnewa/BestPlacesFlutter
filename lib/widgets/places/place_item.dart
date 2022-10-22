import 'package:flutter/material.dart';
import 'package:native_features/models/place.dart';
import 'package:native_features/screens/place_detail.dart';

class PlaceItem extends StatelessWidget {
  const PlaceItem(this.place, {super.key});
  final Place place;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(place.title),
        subtitle: Text('${place.location!.latitude.toString()}/${place.location!.longitude.toString()}'),
        leading: CircleAvatar(
          backgroundImage: FileImage(place.image),
        ),
        onTap: () => Navigator.of(context).pushNamed(PlaceDetailScreen.routeName, arguments: place),
      ),
    );
  }
}
