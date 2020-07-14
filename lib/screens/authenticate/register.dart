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
	final TextEditingController _confirmPassword = TextEditingController();
	final TextEditingController _password = TextEditingController();
	bool loading = false;

	String email = '';
	String password = '';
	String error = '';
	String confirmPassword = '';
	//Color myColor = 0xFFA28629;

	bool validationEqual(String currentValue, String checkValue){
		if( currentValue == checkValue){
			return true;
		} else {
			return false;
		}
	}

	String validatorPassword(String value){
		if(value.isEmpty){
			return 'Enter a password';
		}
		else if(value.length < 6){
			return 'Enter a password with 6 characters or more';
		}
		return null;
	}

	String validatorConfirmPassword(String value){
		if(value.isEmpty){
			return 'Enter a password';
		}
		else if(value.length < 6){
			return 'Enter a password with 6 characters or more';
		}
		return null;	
	}

	@override
	Widget build(BuildContext context){

		return loading ? Loading() : Scaffold(
			backgroundColor: Colors.grey[500],
			appBar: AppBar(
				backgroundColor: Color(0xFFA28629),
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
								validator: (valEmail) => valEmail.isEmpty ? 'Enter a valid email' : null,
								onChanged: (valEmail) {
									setState(() => email = valEmail);
								}
							),

							SizedBox(height: 20.0),

							TextFormField(
								decoration: textInputDecoration.copyWith(hintText: 'Password'),
								controller: _password,
								obscureText: true,
								validator: validatorPassword,
									/*if(val.length < 6){
										'Enter a password 6 characters or more';
									}
									if(_confirmPassword.text != _password.text){
										'Password not match';
									}
									return null;*/
								onChanged: (validatorPassword) {
									setState(() => password = validatorPassword);
								}
							),

							SizedBox(height: 20.0),

							TextFormField(
								decoration: textInputDecoration.copyWith(hintText: 'Confirm Password'),
								obscureText: true,
								controller: _confirmPassword,
								validator: (valConfirmPassword) {
									return valConfirmPassword.isEmpty
										? 'Confirm password is empty'
										: validationEqual (valConfirmPassword, _password.text)
										? null : 'Password not match';
								},
								onChanged: (valConfirmPassword) {
									setState(() => confirmPassword = valConfirmPassword);
								}
							),

							SizedBox(height: 20.0),

							RaisedButton(
								color: Colors.white,
								child: Text('Register',
									style: TextStyle(color: Color(0xFFA28629)),
								),
								onPressed: () async {
									if(_formKey.currentState.validate()){
										setState(() => loading = true);										
										dynamic result = await _auth.registerWithEmailAndPassword(email, password);
										if(result == null){
											setState(() => error = 'Please supply a valid email');
											loading = false;
										}
										print(_password.text);
										print(_confirmPassword.text);
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