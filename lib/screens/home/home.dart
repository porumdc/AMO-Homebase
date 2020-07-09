import 'package:amo/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget{

	final AuthService _auth = AuthService();

	@override
	Widget build(BuildContext context){
		return Scaffold(
			backgroundColor: Colors.blue,
			appBar: AppBar(
				title: Text('Home'),
				backgroundColor: Colors.blue,
				actions: <Widget> [
					FlatButton.icon(
						icon: Icon(Icons.person),
						label: Text('logout'),
						onPressed: () async {
								await _auth.signOut();
						},
					),
				],
			),
		);
	}
}