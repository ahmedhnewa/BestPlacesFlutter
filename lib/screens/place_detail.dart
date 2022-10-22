import 'package:flutter/material.dart';
import 'package:native_features/helpers/location_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/place.dart';

class PlaceDetailScreen extends StatefulWidget {
  const PlaceDetailScreen({Key? key}) : super(key: key);

  static const routeName = '/placeDetail';

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  late Place _place;

  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _place = ModalRoute.of(context)!.settings.arguments as Place;

      _isInit = false;
    }
  }

  double percentageOfBody(double value, double height,
          PreferredSizeWidget appBar, MediaQueryData mediaQuery) =>
      (height - appBar.preferredSize.height - mediaQuery.padding.top) * value;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final appBar = AppBar(
      title: Text(_place.title ?? 'Place details'),
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          SizedBox(
            height: percentageOfBody(0.4, height, appBar, mediaQuery),
            child: Image.file(
              _place.image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: percentageOfBody(0.6, height, appBar, mediaQuery),
            child: WebView(
              initialUrl: LocationHelper.generateLocationPreviewImage(
                latitude: _place.location!.latitude,
                longitude: _place.location!.longitude,
              ),
              javascriptMode: JavascriptMode.unrestricted,
            ),
          )
        ],
      ),
    );
  }
}
