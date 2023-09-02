import 'package:find_tm_app/services/search_service/pythonanywhere_providers/pythonanywhere_ddg_provider.dart';
import 'package:find_tm_app/services/search_service/pythonanywhere_providers/pythonanywhere_modes.dart';
import 'package:find_tm_app/services/search_service/search_result.dart';
import 'package:find_tm_app/services/search_service/search_provider.dart';
import 'package:find_tm_app/services/search_service/pythonanywhere_providers/pythonanywhere_google_provider.dart';
export 'package:find_tm_app/services/search_service/pythonanywhere_providers/pythonanywhere_modes.dart';
export 'package:find_tm_app/services/search_service/search_result.dart';

class SearchService implements SearchProvider {
  SearchService(this._provider);

  SearchProvider _provider;

  factory SearchService.pythonanywhereGoogle(
          {PythonAnywhereModes mode = PythonAnywhereModes.normal}) =>
      SearchService(PythonanywhereGoogleProvider(mode: mode));

  factory SearchService.pythonanywhereDdg(
          {PythonAnywhereModes mode = PythonAnywhereModes.normal}) =>
      SearchService(PythonAnywhereDdgProvider(mode: mode));

  @override
  Future<bool> handShake() => _provider.handShake();

  @override
  String get name => _provider.name;

  @override
  Future<List<SearchResult>> search(String query, {int? numberOfResults}) =>
      _provider.search(query, numberOfResults: numberOfResults);

  void useProxy() {
    switch (_provider.runtimeType) {
      case PythonanywhereGoogleProvider:
        _provider = PythonanywhereGoogleProvider(
            mode: PythonAnywhereModes.withCurlhubProxy);
      default:
        _provider = PythonAnywhereDdgProvider(
            mode: PythonAnywhereModes.withCurlhubProxy);
    }
  }
}
