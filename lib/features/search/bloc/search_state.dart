part of 'search_bloc.dart';

abstract class SearchState {}

class SearchInitial implements SearchState {}

class HideFindTMLogoState implements SearchState {}

class ShowFindTMLogoState implements SearchState {}

class ShowResultsOfSearchSate implements SearchState {}

class LoadingSearchResultsState implements SearchState {}
