import 'package:amo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:amo/services/database.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:amo/models/amomodel.dart';

class Home extends StatelessWidget{

	final AuthService _auth = AuthService();
	final AmoModel amomodel;
	Home ({ this.amomodel });

	@override
	Widget build(BuildContext context){
		
		return StreamProvider<List<AmoModel>>.value(
			value: DatabaseService().amo,
			child: Scaffold(
				appBar: AppBar(
					title: Text('Home'),
					backgroundColor: Color(0xFFA28629),
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
				
				body: Container(
					
				),
			),
		);
	}
}