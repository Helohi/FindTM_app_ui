import 'package:flutter/material.dart';

class HowToStartSearch extends StatelessWidget {
  const HowToStartSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Tap', style: Theme.of(context).textTheme.bodySmall),
        const Icon(Icons.search, color: Colors.grey, size: 30),
        Text('to start search', style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
