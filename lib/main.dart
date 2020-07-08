import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/loading.dart';
import 'pages/choose_mode.dart';
import 'pages/insert_name.dart';

void main() => runApp(MaterialApp(
	initialRoute: '/choose_mode',
	routes: {
		'/': (context) => Loading(),
		'/choose_mode': (context) => ChooseMode(),
		'/home': (context) => Home(),
		'/insert_name': (context) => InsertName(),
	},
));