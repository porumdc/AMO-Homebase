import 'package:firebase_auth/firebase_auth.dart';
import 'package:amo/models/user.dart';
import 'package:amo/services/database.dart';
import 'package:amo/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:amo/screens/authenticate/register.dart';

class SettingsForm extends StatefulWidget {
	@override
	_SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
	final _formKey = GlobalKey<FormState>();

	// form values
	String _firstName;
	String _lastName;
	String _role;
	String loading = 'Done';

	@override
	Widget build(BuildContext context) {

		User user = Provider.of<User>(context);

		return StreamBuilder<UserData>(

			stream: DatabaseService(uid: user.uid).userData,
			builder: (context, snapshot) {
				return Form(
					key: _formKey,
					child: Column(
						children: <Widget>[
							SizedBox(height: 50.0),
							TextFormField(
								decoration: textInputDecoration.copyWith(hintText: 'First name'),
								validator: (val) => val.isEmpty ? 'Please enter first name' : null,
								onChanged: (val) => setState(() => _firstName = val),
							),
							SizedBox(height: 10.0),
							
							TextFormField(
								decoration: textInputDecoration.copyWith(hintText: 'Last name'),
								validator: (val) => val.isEmpty ? 'Please enter last name' : null,
								onChanged: (val) => setState(() => _lastName = val),
							),
							SizedBox(height: 10.0),

							TextFormField(
								decoration: textInputDecoration.copyWith(hintText: 'Access Code'),
								validator: (val) {
									return val.isEmpty
										? 'Enter an access code'
									 	: accessCodeCheck (val)
									 	? null : 'Access Code invalid';
									},
									onChanged: (val) => setState(() => _role = val),
							),
							SizedBox(height: 10.0),
							
							RaisedButton(
								color: Color(0xFFA28629),
								padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 100.0),
								child: Text(
									'Done',
									style: TextStyle(color: Colors.white, fontSize: 15.0),
								),
								onPressed: () async {
									FirebaseUser user = await FirebaseAuth.instance.currentUser();
									String _email = user.email;
									if(_formKey.currentState.validate()){
										await DatabaseService(uid: user.uid).updateUserData(
											_firstName ?? snapshot.data.firstname, 
											_lastName ?? snapshot.data.lastname,
											_role ?? snapshot.data.role,
											_email ?? snapshot.data.email,
											'' ?? snapshot.data.location,
									);
									setState(() => loading = 'Loading. Please wait');
									Navigator.pop(context);
									}
								}
							),
						],
					),
				);
			}
		);
	}

	bool accessCodeCheck(String value){
		if(value == 'contactperson' || value == 'stayin'){
			return true;
		}
		else{
			return false;
		}
	}
}