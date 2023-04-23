import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../core/environment_config.dart';

class CategoryRepo {
  CategoryRepo();
  String url = EnvironmentConfig.BASE_URL;
  Future<Response> getCategory() async {
    try {
      return await http.get(Uri.parse('${url}category'));
    } catch (e) {
      throw Exception('Failed to get cetegory');
    }
  }

  Future<Response> getStoryByCategory(String id) async {
    try {
      return await http
          .get(Uri.parse('${url}category/id/$id/story?page=0&limit=30'));
    } catch (e) {
      throw Exception('Failed to get story');
    }
  }

  Future<Response> pagingStoryByCategory(String id, int page) async {
    try {
      return await http
          .get(Uri.parse('${url}category/id/$id/story?page=$page&limit=30'));
    } catch (e) {
      throw Exception('Failed to get stoyr next page');
    }
  }
}
