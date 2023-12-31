import 'package:dio/dio.dart';
import 'package:find_tm_app/services/google_search/exeptions.dart';
import 'package:find_tm_app/services/google_search/google_result.dart';
import 'package:find_tm_app/services/google_search/google_search_provider.dart';
import 'dart:convert' show jsonDecode;

enum PythonAnywhereModes { normal, withCurlhubProxy }

class PythonanywhereProvider implements GoogleSearchProvider {
  PythonanywhereProvider({required this.mode}) {
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
      final data = jsonDecode(response.data.toString());
      if (data['server_works'] && data['google_search_works']) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw PythonAnywhereDidNotRespond();
    }
  }

  @override
  Future<List<GoogleResult>> search(String query,
      {int? numberOfResults}) async {
    final searchUriToApi = Uri.tryParse(numberOfResults == null
        ? '$_baseUrl/google/$query'
        : '$_baseUrl/google/$query/$numberOfResults');
    if (searchUriToApi != null) {
      final response = await Dio().getUri(searchUriToApi);
      final data = response.data as List;
      return data
          .map((e) => GoogleResult(
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
