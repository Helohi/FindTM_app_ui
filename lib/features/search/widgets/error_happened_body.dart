import 'package:find_tm_app/features/search/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ErrorHappenedBody extends StatelessWidget {
  const ErrorHappenedBody({super.key, required this.state});
  final ExceptionSearchState state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error: ${state.errorDetails}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          ElevatedButton.icon(
            onPressed: () => GetIt.I<SearchBloc>().add(SearchHappendEvent()),
            icon: const Icon(Icons.replay),
            label:
                Text('Try again', style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
