import 'package:find_tm_app/features/search/bloc/search_bloc.dart';
import 'package:find_tm_app/features/search/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool _isSearching = false;

  @override
  void initState() {
    GetIt.I<SearchBloc>().add(EnteringQueryEvent(isSearching: _isSearching));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BlocBuilder<SearchBloc, SearchState>(
        bloc: GetIt.I<SearchBloc>(),
        buildWhen: (previous, current) => current is UpdateFindTMLogoState,
        builder: (context, state) {
          debugPrint(state.toString());
          switch (state) {
            case ShowTextFildForQueryState():
              _isSearching = true;
              return const SearchTextField();
            default:
              _isSearching = false;
              return Text('FindTM',
                  style: Theme.of(context).textTheme.titleLarge);
          }
        },
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              if (_isSearching) {
                GetIt.I<SearchBloc>().add(SearchHappendEvent());
              } else {
                GetIt.I<SearchBloc>()
                    .add(EnteringQueryEvent(isSearching: true));
              }
            },
            icon: const Icon(Icons.search))
      ],
    );
  }
}
