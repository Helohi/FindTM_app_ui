import 'package:find_tm_app/services/google_search/google_result.dart';

abstract class GoogleSearchProvider {
  Future<bool> handShake();

  Future<List<GoogleResult>> search(String query, {int? numberOfResults});
}
