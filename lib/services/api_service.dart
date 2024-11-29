import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:webtoon/models/webtoon_model.dart';

class APIService {
  final String baseURL = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String todyay = "today";

  Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];

    final url = Uri.parse("$baseURL/$todyay");
    final response = await http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        final toon = WebtoonModel.formJson(webtoon);
        webtoonInstances.add(toon);
      }

      return webtoonInstances;
    }
    else {
      throw Error();
    }
  }
}
