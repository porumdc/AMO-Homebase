//import 'package:amo/shared/loading.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:amo/models/user.dart';
import 'package:amo/services/database.dart';
import 'package:amo/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputLocationForm extends StatefulWidget{
	@override
	_InputLocationFormState createState() => _InputLocationFormState();
}

class _InputLocationFormState extends State<InputLocationForm> {
	@override
	Widget build(BuildContext context){

		final _formKey = GlobalKey<FormState>();
		User user = Provider.of<User>(context);

		String loading = '';
		String location = '';

		return StreamBuilder<UserData>(
			stream: DatabaseService(uid: user.uid).userData,
			builder: (context, snapshot){
				return Form(
					key: _formKey,
					child: Column(
						children: <Widget> [
							TextFormField(
								decoration: textInputDecoration.copyWith(hintText: 'Location'),
								validator: (val) => val.isEmpty ? 'Please enter location' : null,
								onChanged: (val) => setState(() => location = val),
							),
							SizedBox(height: 20.0),

							RaisedButton(
								color: Color(0xFFA28629),
								padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 100.0),
								child: Text(
									'Done',
									style: TextStyle(color: Colors.white, fontSize: 15.0),
								),
								onPressed: () async {
									//FirebaseUser user = await FirebaseAuth.instance.currentUser();
									if(_formKey.currentState.validate()){
										await DatabaseService(uid: user.uid).updateUserDataLocation(
											location ?? snapshot.data.location,
									);
									setState(() => loading = 'Loading. Please wait.');
									}
								}
							),

							Text(loading,
								style: TextStyle(color: amoPrimaryColor, fontSize: 14.0),
							),
						],
					),
				);
			}
		);
	}
}