import 'package:find_tm_app/services/google_search/google_result.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ResultListTile extends StatelessWidget {
  const ResultListTile({super.key, required this.googleResult});

  final GoogleResult googleResult;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(googleResult.title),
      titleTextStyle: Theme.of(context).textTheme.bodyLarge,
      subtitle: Text(googleResult.description),
      subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
      leading: IconButton(
        onPressed: () async {
          final url = googleResult.url;
          if (await canLaunchUrlString(url)) {
            await launchUrlString(
              url,
              mode: LaunchMode.externalApplication,
            );
          } else if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Can\'t open url'),
              ),
            );
          }
        },
        icon: const Icon(
          Icons.open_in_browser,
          size: 40,
        ),
      ),
      contentPadding: const EdgeInsets.only(left: 0),
      horizontalTitleGap: 10,
    );
  }
}
