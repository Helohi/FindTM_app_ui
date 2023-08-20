import 'package:find_tm_app/features/search/bloc/search_bloc.dart';
import 'package:find_tm_app/features/search/widgets/widgets.dart';
import 'package:find_tm_app/services/google_search/google_search_service.dart';
import 'package:find_tm_app/services/google_search/pythonanywhere_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    GetIt.I.allowReassignment = true;
    GetIt.I.registerSingleton(QueryInputtedByUser());
    GetIt.I.registerSingleton(SearchBloc());
    GetIt.I.registerSingleton(
      GoogleSearchService.pythonanywhere(PythonAnywhereModes.normal),
    );
    GetIt.I.registerSingleton(GoogleResults());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SearchAppBar(),
      body: SafeArea(child: SearchBody()),
    );
  }
}

class QueryInputtedByUser extends TextEditingController {}

class GoogleResults {
  var results = [];
}
