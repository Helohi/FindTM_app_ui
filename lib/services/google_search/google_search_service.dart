import 'package:find_tm_app/services/google_search/google_result.dart';
import 'package:find_tm_app/services/google_search/google_search_provider.dart';
import 'package:find_tm_app/services/google_search/pythonanywhere_provider.dart';

class GoogleSearchService implements GoogleSearchProvider {
  GoogleSearchService(this._provider);

  final GoogleSearchProvider _provider;

  factory GoogleSearchService.pythonanywhere() =>
      GoogleSearchService(PythonanywhereProvider());

  @override
  Future<bool> handShake() => _provider.handShake();

  @override
  Future<List<GoogleResult>> search(String query, {int? numberOfResults}) =>
      _provider.search(query, numberOfResults: numberOfResults);
}
