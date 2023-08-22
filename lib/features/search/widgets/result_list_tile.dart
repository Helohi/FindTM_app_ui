import 'package:dio/dio.dart';
import 'package:find_tm_app/services/google_search/google_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ResultListTile extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ResultListTile({super.key, required this.googleResult});

  final GoogleResult googleResult;

  @override
  State<ResultListTile> createState() => _ResultListTileState();
}

class _ResultListTileState extends State<ResultListTile>
    with AutomaticKeepAliveClientMixin {
  late final bool? isOpen;
  late final String responseCode;
  late final Future isAvailableFuture;

  Future<void> _checkAvailability() async {
    try {
      final response = await Dio().get(widget.googleResult.url);
      if ([200, 301, 302, 307, 308].contains(response.statusCode)) {
        isOpen = true;
      } else {
        isOpen = null;
      }
      responseCode = response.statusCode.toString();
    } catch (e) {
      responseCode = e.toString();
      isOpen = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListTile(
      onLongPress: () async {
        await Clipboard.setData(ClipboardData(text: widget.googleResult.url));
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Url copied')));
        }
      },
      onTap: () async {
        final url = widget.googleResult.url;
        await launchUrlString(
          url,
          mode: LaunchMode.externalApplication,
        );
      },
      title: Text(widget.googleResult.title),
      titleTextStyle: Theme.of(context).textTheme.bodyLarge,
      subtitle: Text(widget.googleResult.description),
      subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
      leading: FutureBuilder(
        future: _checkAvailability(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (isOpen != null) {
              return Icon(
                isOpen! ? Icons.check_circle : Icons.cancel,
                size: 30,
                color: isOpen! ? Colors.green : Colors.red,
              );
            } else {
              return const Icon(Icons.question_mark, color: Colors.grey);
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
      horizontalTitleGap: 10,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
