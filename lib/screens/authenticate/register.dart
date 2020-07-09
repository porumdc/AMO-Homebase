import 'package:amo/shared/loading.dart';
import 'package:amo/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:amo/services/auth.dart';

class Register extends StatefulWidget{
	final Function toggleView;
	Register ({ this.toggleView });

	@override
	_RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

	final AuthService _auth = AuthService();
	final _formKey = GlobalKey<FormState>();
	bool loading = false;

	String email = '';
	String password = '';
	String error = '';
	//Color myColor = af923d;

	@override
	Widget build(BuildContext context){

		return loading ? Loading() : Scaffold(
			backgroundColor: Colors.grey[500],
			appBar: AppBar(
				backgroundColor: Color(0xFFAF923D),
				title: Text("Register"),
				actions: <Widget> [
					FlatButton.icon(
						icon: Icon(Icons.person),
						label: Text('Sign in'),
						onPressed: () {
							widget.toggleView();
						},
					),
				],
			),

			body: Container(
				padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
				child: Form(

					key: _formKey,

					child: Column(
						children: <Widget> [

							SizedBox(height: 20.0),

							TextFormField(
								decoration: textInputDecoration.copyWith(hintText: 'Email'),
								validator: (val) => val.isEmpty ? 'Enter a valid email' : null,
								onChanged: (val) {
									setState(() => email = val);
								}
							),

							SizedBox(height: 20.0),

							TextFormField(
								decoration: textInputDecoration.copyWith(hintText: 'Password'),
								obscureText: true,
								validator: (val) => val.length < 6 ? 'Enter a password 6 characters or more' : null,
								onChanged: (val) {
									setState(() => password = val);
								}
							),

							SizedBox(height: 20.0),

							RaisedButton(
								color: Colors.white,
								child: Text('Register',
									style: TextStyle(color: Color(0xFFAF923D)),
								),
								onPressed: () async {
									if(_formKey.currentState.validate()){
										setState(() => loading = true);										
										dynamic result = await _auth.registerWithEmailAndPassword(email, password);
										if(result == null){
											setState(() => error = 'Please supply a valid email');
											loading = false;
										}
									}
								},
							),

							SizedBox(height: 12.0),

							Text(error,
								style: TextStyle(color: Colors.red, fontSize: 14.0),
							),

						],					
					),
				),
			),
		);
	}
}