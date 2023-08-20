import 'package:find_tm_app/features/search/search.dart';
import 'package:find_tm_app/services/google_search/google_search_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<EnteringQueryEvent>((event, emit) {
      event.isSearching
          ? emit(ShowTextFildForQueryState())
          : emit(ShowFindTMLogoState());
    });

    on<SearchHappendEvent>((event, emit) async {
      emit(LoadingSearchResultsState());
      try {
        GetIt.I<GoogleResults>().results = await GetIt.I<GoogleSearchService>()
            .search(GetIt.I<QueryInputtedByUser>().text.toString(),
                numberOfResults: 20);
        emit(ShowResultsOfSearchSate());
      } catch (e) {
        emit(ExceptionSearchState(
            errorDetails:
                "Server did not send response.\nDetails: ${e.toString()}"));
      }
    });
  }
}
