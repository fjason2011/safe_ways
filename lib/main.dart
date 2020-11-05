import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homePage.dart';

void main() {
  return runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AppState(),)
  ],
    child: MyApp(),));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe Ways',
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: HomePage(),
    );
  }
}