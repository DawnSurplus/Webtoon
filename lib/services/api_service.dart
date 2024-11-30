import 'dart:convert';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:webtoon/models/webtoon_detail_model.dart';
import 'package:webtoon/models/webtoon_episode_model.dart';
import 'package:webtoon/models/webtoon_model.dart';
import 'package:webtoon/widgets/webtoon_widget.dart';

class APIService {
  static const String baseURL =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String todyay = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
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
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseURL/$id");
    final response = await http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];

    final url = Uri.parse("$baseURL/$id/episodes");
    final response = await http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}
