import 'package:amo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:amo/services/database.dart';
import 'package:provider/provider.dart';
import 'package:amo/models/user.dart';
import 'package:amo/screens/home/sethome.dart';
import 'package:amo/screens/home/stayinpage.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget{
	@override
	_HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

	final AuthService _auth = AuthService();	

	@override
	Widget build(BuildContext context){

		User user = Provider.of<User>(context);

		return StreamBuilder<UserData>(
			stream: DatabaseService(uid: user.uid).userData,
			builder: (context, snapshot){
				if(snapshot.data.role == 'contactperson'){
					return Scaffold(
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
						body: SetHome(),
					);
				}	
				else{
					return Scaffold(
						backgroundColor: Colors.black,
						appBar: AppBar(
							title: Text('Guest Page'),
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
						body: StayinPage(),
					);
				}
			}
		);
		
		/*return StreamProvider<List<AmoModel>>.value(
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
				
				body: amomodel.role == 'contactperson'
					? AmoMemberList()
					: Text('Henlo'),
			),
		);*/

	}
}