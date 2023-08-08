import 'dart:convert';
import 'package:http/http.dart' as http;

class SectionsService {
  final String _url = "https://content.guardianapis.com/sections";
  final String _apikey = "56ab7f8a-3da1-4710-8311-8c5160f239aa";

  Future<List<dynamic>> getCategories(Function(int status) onStatusCodeError,
      Function(Exception e) onException) async {
    Uri uri = Uri.parse("$_url?api-key=$_apikey");

    Map<String, dynamic> data = {};
    List<dynamic> results = [];

    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        data = json.decode(response.body);
        results = data['response']['results'];
      } else {
        onStatusCodeError(response.statusCode);
      }
    } on Exception catch (e) {
      onException(e);
    }

    return results;
  }
}