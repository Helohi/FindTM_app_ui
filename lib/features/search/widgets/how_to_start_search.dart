import 'package:flutter/material.dart';

class HowToStartSearch extends StatelessWidget {
  const HowToStartSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle =
        Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 15);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Tap', style: textStyle),
        const Icon(Icons.search, color: Colors.grey, size: 30),
        Text('to start search', style: textStyle),
        const Column(),
      ],
    );
  }
}
