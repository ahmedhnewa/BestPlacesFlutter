const googleApiKey = '';

class LocationHelper {
  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
    double zoom = 18,
  }) {
    return 'https://www.google.com/maps/@$latitude,$longitude,${zoom}z';
  }
}
