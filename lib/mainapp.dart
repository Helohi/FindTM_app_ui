import 'package:find_tm_app/theme/theme.dart';
import 'package:flutter/material.dart';

import 'features/search/search.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: theme,
      home: const SearchScreen(),
    );
  }
}
