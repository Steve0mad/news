import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_c10_str/shared/components/constants.dart';
import '../../../models/news_response.dart';
import '../../../models/source_reposne.dart';

class ApiManager {
  static Future<SourceResponse> getSources(String category) async {
    Uri url = Uri.https(Constants.BASE_URL, "/v2/top-headlines/sources",
        {"apiKey": "050460483215412993fe3f8dcebc160c", "category": category});
    http.Response resposne = await http.get(url);
    Map<String, dynamic> json = jsonDecode(resposne.body);

    return SourceResponse.fromJson(json);
  }

  static Future<NewsResponse> getNewsData(String sourceId) async {
    Uri url = Uri.https(Constants.BASE_URL, "/v2/everything", {
      "apiKey": "050460483215412993fe3f8dcebc160c",
      "sources": sourceId,
    });
    var resposne = await http.get(url);

    var json = jsonDecode(resposne.body);
    return NewsResponse.fromJson(json);
  }
}
