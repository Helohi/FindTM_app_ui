import 'package:find_tm_app/services/search_service/search_result.dart';

abstract class SearchProvider {
  Future<bool> handShake();

  Future<List<SearchResult>> search(String query, {int? numberOfResults});
}
