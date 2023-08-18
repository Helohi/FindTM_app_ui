import 'package:dio/dio.dart';
import 'package:find_tm_app/services/google_search/google_result.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ResultListTile extends StatefulWidget {
  const ResultListTile({super.key, required this.googleResult});

  final GoogleResult googleResult;

  @override
  State<ResultListTile> createState() => _ResultListTileState();
}

class _ResultListTileState extends State<ResultListTile> {
  late final bool isOpen;
  late final Future isAvailableFuture;

  Future<void> _checkAvailability() async {
    try {
      final response = await Dio().get(widget.googleResult.url);
      if ([200, 301, 302, 307, 308].contains(response.statusCode)) {
        isOpen = true;
      } else {
        isOpen = false;
      }
    } catch (e) {
      isOpen = false;
    }
  }

  @override
  void initState() {
    isAvailableFuture = _checkAvailability();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        final url = widget.googleResult.url;
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
      title: Text(widget.googleResult.title),
      titleTextStyle: Theme.of(context).textTheme.bodyLarge,
      subtitle: Text(widget.googleResult.description),
      subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
      leading: FutureBuilder(
        future: isAvailableFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Icon(
              isOpen ? Icons.check_circle : Icons.cancel,
              size: 30,
              color: isOpen ? Colors.green : Colors.red,
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
      horizontalTitleGap: 10,
    );
  }
}
