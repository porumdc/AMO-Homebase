import 'package:amo/services/database.dart';
import 'package:flutter/material.dart';
import 'package:amo/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:amo/models/user.dart';

class StayinPage extends StatefulWidget{
	@override
	_StayinPageState createState() => _StayinPageState();
}

class _StayinPageState extends State<StayinPage>{
	bool isSwitched = true;
	final _formKey = GlobalKey<FormState>();
	String loading = '';
	String location = '';

	@override
	Widget build(BuildContext context){
		User user = Provider.of<User>(context);


		return StreamBuilder<UserData>(
			stream: DatabaseService(uid: user.uid).userData,
			builder: (context, snapshot){
				return Form(
					key: _formKey,
					child: SingleChildScrollView(
						child: Container(
							margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 120.0),
							padding: const EdgeInsets.all(50.0),
							decoration: BoxDecoration(
								color: Colors.black,
								border: Border.all(
									color: amoPrimaryColor,
									width: 5.0
								),
								borderRadius: BorderRadius.all(
									Radius.circular(10.0),
								),
							),
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.center,
								children: <Widget> [
									Container(
										child: Container(
											child: Row(
												mainAxisAlignment: MainAxisAlignment.spaceBetween,
												children: <Widget> [
													Text('Going out?',
														style: TextStyle(
															color: amoPrimaryColor,
															fontSize: 20,
														),
													),

													SizedBox(width: 10.0),

													Switch(
														value: isSwitched,
														onChanged: (value){
															setState(() => isSwitched = value);
														},
														activeTrackColor: Color(0xFFA28629),
														activeColor: Color(0xFFA28629),
													),
												],
											),
										),
									),

									SizedBox(height: 20.0),

									TextFormField(
										decoration: textInputDecoration.copyWith(hintText: 'Location'),
										validator: (val) => val.isEmpty ? 'Please enter location' : null,
										onChanged: (val) => setState(() => location = val),
									),

									SizedBox(height: 20.0),

									Container(
										child: Row(
											children: <Widget> [
												AnimatedOpacity(
													opacity: isSwitched ? 1.0 : 0.0,
													duration: Duration(milliseconds: 500),
													child: Container(
														child: RaisedButton(
															color: Color(0xFFA28629),
															padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 100.0),
															child: Text('Done',
																style: TextStyle(color: Colors.white, fontSize: 15.0),
															),
															onPressed: () async {
																//FirebaseUser user = await FirebaseAuth.instance.currentUser();
																if(_formKey.currentState.validate()){
																	print(location);
																	await DatabaseService(uid: user.uid).updateUserDataLocation(
																		snapshot.data.firstname ?? snapshot.data.firstname,
																		snapshot.data.lastname ?? snapshot.data.lastname,
																		snapshot.data.role ?? snapshot.data.role,
																		snapshot.data.email ?? snapshot.data.email,
																		location ?? snapshot.data.location,
																);
																print('here2');
																setState(() => loading = 'Loading. Please wait.');
																}
																print('here3');
																setState(() => loading = 'Location updated');
															}
														),
													),
												),
											],
										),
									),

									SizedBox(height: 20.0),

									Text(loading,
										style: TextStyle(color: amoPrimaryColor, fontSize: 14.0),
									),

								],
							),
						),
					),
				);
			},
		);
	}
}