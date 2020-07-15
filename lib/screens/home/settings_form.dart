import 'package:amo/models/user.dart';
import 'package:amo/services/database.dart';
import 'package:amo/shared/constants.dart';
//import 'package:amo/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();

  // form values
  String _firstName;
  String _lastName;

  @override
  Widget build(BuildContext context) {

	User user = Provider.of<User>(context);

	return StreamBuilder<UserData>(
	  stream: DatabaseService(uid: user.uid).userData,
	  builder: (context, snapshot) {
		  //UserData userData = snapshot.data;
		  return Form(
			key: _formKey,
			child: Column(
			  children: <Widget>[
				SizedBox(height: 20.0),
				TextFormField(
				  //initialValue: userData.firstname,
				  decoration: textInputDecoration.copyWith(hintText: 'First name'),
				  validator: (val) => val.isEmpty ? 'Please enter first name' : null,
				  onChanged: (val) => setState(() => _firstName = val),
				),
				SizedBox(height: 10.0),
				
				TextFormField(
				  //initialValue: userData.lastname,
				  decoration: textInputDecoration.copyWith(hintText: 'Last name'),
				  validator: (val) => val.isEmpty ? 'Please enter last name' : null,
				  onChanged: (val) => setState(() => _lastName = val),
				),
				SizedBox(height: 10.0),
				
				RaisedButton(
				  color: Colors.pink[400],
				  child: Text(
					'Update',
					style: TextStyle(color: Colors.white),
				  ),
				  onPressed: () async {
					if(_formKey.currentState.validate()){
					  await DatabaseService(uid: user.uid).updateUserData(
						_firstName ?? snapshot.data.firstname, 
						_lastName ?? snapshot.data.lastname,
					  );
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
}