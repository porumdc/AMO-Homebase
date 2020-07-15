import 'package:amo/shared/loading.dart';
import 'package:amo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:amo/shared/constants.dart';

class SignIn extends StatefulWidget {

	final Function toggleView;
	SignIn ({ this.toggleView });

	@override
	_SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn>{

	final AuthService _auth = AuthService();
	final _formKey = GlobalKey<FormState>();
	bool loading = false;

	String email = '';
	String password = '';
	String error = '';

	@override
	Widget build(BuildContext context){
		return loading ? Loading() : Scaffold(
			backgroundColor: Colors.black,
			appBar: AppBar(
				backgroundColor: Color(0xFFA28629),
				title: Text('Sign in'),
				actions: <Widget> [
					FlatButton.icon(
						icon: Icon(Icons.person),
						label: Text('Register'),
						onPressed: () {
							widget.toggleView();
						},
					),
				],
			),

			body: SingleChildScrollView(
				child: Padding(
					padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),

					child: Column(

						children: <Widget> [
							Image.asset('lib/assets/amologo.png',
								height: 200,
								width: 200,
							),

							Text('M  I  S  S  I  O  N    B  A  S  E',
								style: TextStyle(
									fontFamily: 'Montserrat',
									color: Color(0xFFA28629),
									fontWeight: FontWeight.bold,
									fontSize: 16.0),
							),

							Form(

								key: _formKey,

								child: Column(
									children: <Widget>[

										SizedBox(height: 20.0),

										TextFormField(
											decoration: textInputDecoration.copyWith(hintText: 'Email'),
											validator: (val) => val.isEmpty ? 'Enter an email' : null,
											onChanged: (val) {
												setState(() => email = val);
											}
										),

										SizedBox(height: 20.0),

										TextFormField(
											decoration: textInputDecoration.copyWith(hintText: 'Password'),
											validator: (val) => val.length < 6 ? 'Enter a password 6 characters or more' : null,
											obscureText: true,
											onChanged: (val) {
												setState(() => password = val);
											}
										),

										SizedBox(height: 20.0),

										RaisedButton(
											color: Colors.white,
											padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 15.0),
											child: Text('Sign in',
												style: TextStyle(color: Color(0xFFA28629), fontSize: 15.0),
											),
											onPressed: () async {
												if(_formKey.currentState.validate()){
													setState(() => loading = true);
													dynamic result = await _auth.signInWithEmailAndPassword(email, password);
													if(result == null){
														setState(() => error = 'Could not sign in with those credentials');
														loading = false;
													}
												}
											},
										),

										SizedBox(height: 20.0),

										Text(error,
											style: TextStyle(color: Colors.red, fontSize: 14.0),
										),

									],					
								),
							),
						],
					),
				),
			),
		);
	}
}