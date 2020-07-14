import 'package:amo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:amo/services/database.dart';
import 'package:provider/provider.dart';
import 'package:amo/screens/home/amodatalist.dart';
import 'package:amo/models/amomodel.dart';

class Home extends StatelessWidget{

	final AuthService _auth = AuthService();

	@override
	Widget build(BuildContext context){
		return StreamProvider<List<AmoModel>>.value(
			value: DatabaseService().amo,
			child: Scaffold(
				backgroundColor: Colors.blue,
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
				body: AmoDataList(),
			),
		);
	}
}