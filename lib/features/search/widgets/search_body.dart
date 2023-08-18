import 'package:find_tm_app/features/search/bloc/search_bloc.dart';
import 'package:find_tm_app/features/search/search.dart';
import 'package:find_tm_app/features/search/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({super.key});

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        GetIt.I<SearchBloc>().add(EnteringQueryEvent(isSearching: false));
      },
      child: BlocBuilder<SearchBloc, SearchState>(
          bloc: GetIt.I<SearchBloc>(),
          buildWhen: (previous, current) => current is UpdateResultsListView,
          builder: (context, state) {
            switch (state.runtimeType) {
              case LoadingSearchResultsState:
                return const Center(child: CircularProgressIndicator());
              case ShowResultsOfSearchSate:
                return ListView.separated(
                  separatorBuilder: (context, index) =>
                      const Divider(thickness: 2, color: Colors.brown),
                  itemCount: GetIt.I<GoogleResults>().results.length,
                  itemBuilder: (context, index) {
                    return ResultListTile(
                      googleResult: GetIt.I<GoogleResults>().results[index],
                    );
                  },
                );
              case ExceptionSearchState:
                return ErrorHappenedBody(state: state as ExceptionSearchState);
              default:
                return const HowToStartSearch();
            }
          }),
    );
  }
}
