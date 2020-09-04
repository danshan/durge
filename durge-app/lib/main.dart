import 'package:durge/config/prefs_model.dart';
import 'package:durge/main_page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

void main() {
  debugPaintSizeEnabled = false;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => PrefsModel()),
    ],
    child: MaterialApp(title: 'Durge', home: MainPage()),
  ));
}
