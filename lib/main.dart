import 'package:amo/models/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:amo/screens/wrapper.dart';
import 'package:amo/services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

	@override
	Widget build(BuildContext context){
		return StreamProvider<User>.value(
			value: AuthService().user,
			child: MaterialApp(
				home: Wrapper(),
			),
		);
	}
}