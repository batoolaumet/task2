import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchService {
  final String _url = "https://content.guardianapis.com/search";
  final String _apiKey = "56ab7f8a-3da1-4710-8311-8c5160f239aa";

  Future<List<dynamic>> getNewsByCategory(
      int page,
      int pageSize,
      String category,
      String fromDate,
      String toDate,
      String orderBy,
      Function(int status) onStatusCodeError,
      Function(Exception e) onException) async {
    Uri uri;
    if (category.toLowerCase() == "home") {
      String x =
          "$_url?api-key=$_apiKey&show-fields=thumbnail,body-text&page=$page&page-size=$pageSize&from-date=${DateTime.parse(fromDate).toIso8601String()}&to-date=${DateTime.parse(toDate).toIso8601String().substring(0, 10)}&order-by=$orderBy";
      print(x);
      //get all categories
      uri = Uri.parse(x);
    } else {
      uri = Uri.parse(
          "$_url?api-key=$_apiKey&show-fields=thumbnail,body-text&page=$page&page-size=$pageSize&section=${category.toLowerCase()}&from-date=${DateTime.parse(fromDate).toIso8601String().substring(0, 10)}&to-date=${DateTime.parse(toDate).toIso8601String()}&order-by=$orderBy");
    }

    Map<String, dynamic> data = {};
    List<dynamic> results = [];

    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        data = json.decode(response.body);
        results = data['response']['results'];
      } else {
        print("status error code: ${response.statusCode}");
        onStatusCodeError(response.statusCode);
      }
    } on Exception catch (e) {
      onException(e);
    }

    return results;
  }
}