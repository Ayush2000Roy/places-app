import 'dart:convert';
import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'GoogleApiKey';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'searchGoogleStaticApiMap';
  }

  static Future<String> getPlacesAddress(double lat, double lng) async {
    final url = 'https://geocodingurl.com';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
