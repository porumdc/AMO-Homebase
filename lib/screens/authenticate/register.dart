import 'package:amo/shared/loading.dart';
import 'package:amo/shared/constants.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:amo/services/auth.dart';
import 'package:amo/models/amomodel.dart';
import 'package:amo/services/database.dart';
import 'package:provider/provider.dart';
import 'package:amo/screens/home/settings_form.dart';


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
	//final TextEditingController _firstName = TextEditingController();
	//final TextEditingController _lastName = TextEditingController();
	bool loading = false;

	String email = '';
	String password = '';
	String error = '';
	String confirmPassword = '';
	//String firstName = '';
	//String lastName = '';
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

	void _showSettingsPanel(){

		showModalBottomSheet(context: context, isScrollControlled: true, builder: (context){
			return Scaffold(
				body: Padding(
					padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
					child: Column(
						children: <Widget> [
							GestureDetector(
								behavior: HitTestBehavior.opaque,
								onTap: () {},
								child: SettingsForm(),
							),
						],
					),
				),
			);
		});
	}

	@override
	Widget build(BuildContext context){

		return loading ? Loading() : StreamProvider<List<AmoModel>>.value(
			value: DatabaseService().amo,

			child: Scaffold(
				backgroundColor: Colors.black,
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

				body: SingleChildScrollView(
					child: Padding(
						padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),

						child: Column(

							children: <Widget> [

								Form(
									key: _formKey,
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
												padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 15.0),
												child: Text('Register',
													style: TextStyle(color: Color(0xFFA28629), fontSize: 15.0),
												),
												onPressed: () async {
													if(_formKey.currentState.validate()){
														//setState(() => loading = true);							
														dynamic result = await _auth.registerWithEmailAndPassword(email, password); //, firstName, lastName);
														if(result == null){
															setState(() => error = 'Please supply a valid email');
															//loading = false;
														}
													}
													_showSettingsPanel();
												},
											),

											SizedBox(height: 12.0),

											Text(error,
												style: TextStyle(color: Colors.red, fontSize: 14.0),
											),

										],// children				
									),
								),
							],
						),
					),
				),
			),
		);
	}
}