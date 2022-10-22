import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/screens/add_place.dart';
import '/providers/places.dart';
import '/widgets/places/place_item.dart';

class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, AddPlaceScreen.routeName),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchPlaces(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()),);
          }

          return Consumer<Places>(
            builder: (context, places, child) => places.isEmpty
                ? child!
                : ListView.builder(
                    itemBuilder: (BuildContext context, int index) =>
                        PlaceItem(places.items[index]),
                    itemCount: places.itemCount,
                  ),
            child: const Center(child: Text('No data yet')),
          );
        },
      ),
    );
  }
}
