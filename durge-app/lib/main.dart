import 'package:durge/main_page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = false;

  runApp(MaterialApp(title: 'Durge', home: MainPage()));
}
