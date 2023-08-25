import 'package:find_tm_app/services/search_service/search_result.dart';
import 'package:find_tm_app/services/search_service/search_provider.dart';
import 'package:find_tm_app/services/search_service/pythonanywhere_providers/pythonanywhere_google_provider.dart';
export 'package:find_tm_app/services/search_service/pythonanywhere_providers/pythonanywhere_modes.dart';

class SearchService implements SearchProvider {
  SearchService(this._provider);

  final SearchProvider _provider;

  factory SearchService.pythonanywhere(mode) =>
      SearchService(PythonanywhereGoogleProvider(mode: mode));

  @override
  Future<bool> handShake() => _provider.handShake();

  @override
  Future<List<SearchResult>> search(String query, {int? numberOfResults}) =>
      _provider.search(query, numberOfResults: numberOfResults);
}
