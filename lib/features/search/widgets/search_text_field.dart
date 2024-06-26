import 'package:find_tm_app/features/search/bloc/search_bloc.dart';
import 'package:find_tm_app/features/search/search.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: TextField(
        onSubmitted: (value) {
          GetIt.I<SearchBloc>().add(SearchHappendEvent());
        },
        style: Theme.of(context).textTheme.titleMedium,
        controller: GetIt.I<QueryInputtedByUser>(),
        autofocus: true,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
