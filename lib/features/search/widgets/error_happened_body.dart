import 'package:find_tm_app/features/search/bloc/search_bloc.dart';
import 'package:find_tm_app/services/google_search/google_search_service.dart';
import 'package:find_tm_app/services/google_search/pythonanywhere_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ErrorHappenedBody extends StatelessWidget {
  const ErrorHappenedBody({super.key, required this.state});
  final ExceptionSearchState state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
              label: const Text(
                'Try again',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                GetIt.I.registerSingleton(
                  GoogleSearchService.pythonanywhere(
                    PythonAnywhereModes.withCurlhubProxy,
                  ),
                );
                GetIt.I<SearchBloc>().add(SearchHappendEvent());
              },
              child: const Text('Activate proxy'),
            )
          ],
        ),
      ),
    );
  }
}
