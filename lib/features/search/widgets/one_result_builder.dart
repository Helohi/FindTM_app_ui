import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:find_tm_app/services/search_service/search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'dart:developer' show log;

class OneResultBuilder extends StatefulWidget {
  const OneResultBuilder({super.key, required this.googleResult});

  final SearchResult googleResult;

  @override
  State<OneResultBuilder> createState() => _OneResultBuilderState();
}

class _OneResultBuilderState extends State<OneResultBuilder>
    with AutomaticKeepAliveClientMixin {
  late final Future<void> checkAvailability;
  late final Future isAvailableFuture;
  late final String responseCode;
  late final bool? isOpen;
  static const maxUrlLen = 50;

  Future<void> _checkAvailability() async {
    try {
      final response = await Dio().get(widget.googleResult.url,
          options:
              Options(headers: {'User-Agent': faker.internet.userAgent()}));
      if ([200, 301, 302, 307, 308].contains(response.statusCode)) {
        isOpen = true;
      } else {
        isOpen = null;
      }
      responseCode = response.statusCode.toString();
    } on DioException catch (diEx) {
      log(diEx.toString());
      responseCode = diEx.toString();
      isOpen = (diEx.response?.statusCode == 403 ? true : false);
    }
  }

  @override
  void initState() {
    super.initState();
    checkAvailability = _checkAvailability();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GestureDetector(
      onTap: () async {
        final url = widget.googleResult.url;
        await launchUrlString(
          url,
          mode: LaunchMode.externalApplication,
        );
      },
      onLongPress: () async {
        await Clipboard.setData(ClipboardData(text: widget.googleResult.url));
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Url copied')));
        }
      },
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 8),
            child: Text(
              widget.googleResult.url.length > maxUrlLen
                  ? widget.googleResult.url.replaceRange(maxUrlLen - 10,
                      widget.googleResult.url.length - 10, '...')
                  : widget.googleResult.url,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          ListTile(
            title: Text(widget.googleResult.title),
            titleTextStyle: Theme.of(context).textTheme.bodyLarge,
            subtitle: Text(widget.googleResult.description),
            subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
            leading: FutureBuilder(
              future: checkAvailability,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (isOpen != null) {
                    return Icon(
                      isOpen! ? Icons.check_circle : Icons.cancel,
                      size: 40,
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
            horizontalTitleGap: 8,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
