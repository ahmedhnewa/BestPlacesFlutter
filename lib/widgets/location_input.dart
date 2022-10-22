import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:native_features/helpers/location_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '/models/place.dart';

class LocationInput extends StatefulWidget {
  const LocationInput(this.onPickupLocation, {Key? key}) : super(key: key);

  final void Function(LocationPlace) onPickupLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  // String? _previewImageUrl;
  String _url = '';

  Future<void> _getCurrentUserLocation() async {
    final location = await Location().getLocation();
    print(location.latitude);
    print(location.longitude);
    final locationPlace = LocationPlace(
      longitude: location.longitude!,
      latitude: location.latitude!,
    );
    setState(() {
      _url = LocationHelper.generateLocationPreviewImage(
          latitude: location.latitude!, longitude: location.longitude!);
    });
    widget.onPickupLocation(locationPlace);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          height:
              _url.isEmpty ? 150 : MediaQuery.of(context).size.height * 0.55,
          width: double.infinity,
          duration: const Duration(milliseconds: 300),
          child: _url.isEmpty
              ? const Center(
                  child: Text(
                    'No Map',
                    textAlign: TextAlign.center,
                  ),
                )
              : WebView(
                  initialUrl: _url,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebResourceError: (error) => print(error),
                  key: UniqueKey(),
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
            ),
            TextButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 10),
                  content: Text(
                      'Sorry, I don\'t have credit card that can accepted by google cloud console so I can\'t use their api'),
                ));
              },
              icon: const Icon(Icons.map),
              label: const Text('Select on map'),
            ),
          ],
        )
      ],
    );
  }
}
