import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../core/environment_config.dart';

class StoryRepo {
  StoryRepo();
  String url = EnvironmentConfig.BASE_URL;
  Future<Response> getStoryDetail(String id) async {
    try {
      return await http.get(Uri.parse('${url}story/id/$id'));
    } catch (e) {
      throw Exception('Failed to get story detail');
    }
  }

  Future<Response> getAllChapter(String slug) async {
    try {
      return await http.get(Uri.parse('${url}story/$slug/chapters'));
    } catch (e) {
      throw Exception('Failed to get all chater');
    }
  }

  Future<Response> getChapterDetail(String id) async {
    try {
      return await http.get(Uri.parse('${url}chapter/id/$id'));
    } catch (e) {
      throw Exception('Failed to get chapter detail');
    }
  }
}
