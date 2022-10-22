import 'dart:io';

class LocationPlace {
  final double latitude;
  final double longitude;
  final String address;

  LocationPlace({
    required this.latitude,
    required this.longitude,
    this.address = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }

  factory LocationPlace.fromMap(Map<String, dynamic> map) {
    return LocationPlace(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      address: map['address'] as String,
    );
  }
}

class Place {
  final String id;
  final String title;
  final LocationPlace? location;
  final File image;

  Place({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });
}
