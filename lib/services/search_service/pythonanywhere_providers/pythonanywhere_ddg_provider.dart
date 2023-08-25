import 'package:dio/dio.dart';
import 'package:find_tm_app/services/search_service/exeptions.dart';
import 'package:find_tm_app/services/search_service/pythonanywhere_providers/pythonanywhere_modes.dart';
import 'package:find_tm_app/services/search_service/search_provider.dart';
import 'package:find_tm_app/services/search_service/search_result.dart';

class PythonAnywhereDdgProvider implements SearchProvider {
  PythonAnywhereDdgProvider({required this.mode}) {
    switch (mode) {
      case PythonAnywhereModes.withCurlhubProxy:
        _baseUrl = 'https://findtm-pythonanywhere-com-nphllvybqwfl.curlhub.io';
      default:
        _baseUrl = 'https://findtm.pythonanywhere.com';
    }
  }

  final PythonAnywhereModes mode;

  late final String _baseUrl;

  @override
  Future<bool> handShake() async {
    try {
      final response = await Dio().get('$_baseUrl/');
      final data = response.data as Map;
      if (data['server_works'] && data['duckduckgo']) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw PythonAnywhereDidNotRespond();
    }
  }

  @override
  Future<List<SearchResult>> search(String query,
      {int? numberOfResults}) async {
    final searchUriToApi = Uri.tryParse(numberOfResults == null
        ? '$_baseUrl/ddg/$query'
        : '$_baseUrl/ddg/$query/$numberOfResults');
    if (searchUriToApi != null) {
      final response = await Dio().getUri(searchUriToApi);
      final data = response.data as List;
      return data
          .map((e) => SearchResult(
                url: e['url'],
                title: e['title'],
                description: e['description'],
              ))
          .toList();
    } else {
      throw EnableToParseQuery();
    }
  }
}
