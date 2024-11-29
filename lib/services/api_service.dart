import 'dart:io';
import 'package:http/http.dart' as http;

class APIService {
  final String baseURL = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String todyay = "today";

  void getTodaysToons() async {
    final url = Uri.parse("$baseURL/$todyay");
    final response = await http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      print(response.body);
    } else {
      throw Error();
    }
  }
}
