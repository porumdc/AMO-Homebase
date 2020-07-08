import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

class ChooseMode extends StatefulWidget {
	@override
	_ChooseModeState createState() => _ChooseModeState();
}

class Data{
}

class _ChooseModeState extends State<ChooseMode> {

	//final GlobalKey<FormState> _form = GlobalKey<FormState>();
	final TextEditingController _pass = TextEditingController();
	final TextEditingController _confirmPass = TextEditingController();
	DateTime selectedData;
	final myController = TextEditingController();
	bool _canShowLoginForm = true;
	bool _canShowRegisterForm = false;
	String mode = "Register";
	String _validation = "password does not match";

	void validate(){
		if(_pass.text == _confirmPass.text){
			print("password matched");
			_validation = "password matched";
		}
		
		else{
			print("password does not match");
			setState((){
				_validation = "password does not match";
			});
		}
	}

	void dispose(){
		myController.dispose();
		super.dispose();
	}

	void hideButton(){
		
		if(_canShowLoginForm == true){

			setState((){
				_canShowLoginForm = false;
				_canShowRegisterForm = true;
				mode = "Login";
			});

			print("hide");
		}

		else if(_canShowLoginForm == false){

			setState((){
				_canShowLoginForm = true;
				_canShowRegisterForm = false;
				mode = "Register";
			});

			print("show");
		}
	}

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			backgroundColor: Colors.blue,
			body: new Container(
				alignment: Alignment.center,

				child: Column(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					mainAxisAlignment: MainAxisAlignment.center,

					children: <Widget>[

						//INPUT FIELD - First Name
						Visibility(
							visible: _canShowRegisterForm,
							child: TextField(
								controller: myController,
								decoration: new InputDecoration(
									hintText: "First name",
								),
							),
						),

						//SPACING
						SizedBox(height: 10.0),
						
						//INPUT FIELD - Last Name
						Visibility(
							visible: _canShowRegisterForm,
							child: TextField(
								controller: myController,
								decoration: new InputDecoration(
									hintText: "Last name",
								),
							),
						),

						//SPACING
						SizedBox(height: 10.0),

						//INPUT FIELD - username
						Visibility(
							//visible: _canShowLoginForm,
							child: TextField(
								controller: myController,
								decoration: new InputDecoration(
									hintText: "Email Address",
								),
							),
						),

						//SPACING
						SizedBox(height: 10.0),

						/*Form(
							key: _form,
							child: ListView(
								children: <Widget> [
									TextFormField(
										controller: _pass,
										validator: (val){
											if(val.isEmpty)
												return 'Empty';
											return null;
											}
									),

									TextFormField(
										controller: _confirmPass,
										validator: (val){
											if(val.isEmpty)
												return 'Empty';
											if(val != _pass.text)
												return 'Not match';
											return null;
										}
									),
								],
							),
						),*/

						//INPUT FIELD - password
						Visibility(
							//visible: _canShowLoginForm,
							child: TextField(
								controller: _pass,
								decoration: new InputDecoration(
									hintText: "Password",
								),
							),
						),

						//SPACING
						SizedBox(height: 10.0),

						//INPUT FIELD - password
						Visibility(
							visible: _canShowRegisterForm,
							child: TextField(
								controller: _confirmPass,
								decoration: new InputDecoration(
									hintText: "Confirm Password",
								),
							),
						),

						//SPACING
						SizedBox(height: 30.0),

						Visibility(
							visible: _canShowRegisterForm,

							child: DateField(
							    onDateSelected: (DateTime value) {
									setState(() {
							        	selectedData = value;
							    	});
							    },
							    selectedDate: selectedData,
							),
						),

						SizedBox(height: 10.0),

						// BUTTON
						Visibility(
							//visible: _canShowLoginForm,
							child: FlatButton(
								color: Colors.white,
								onPressed: validate,
								child: Text('Confirm'),
								shape: RoundedRectangleBorder(
									borderRadius: BorderRadius.circular(36.0),
									side: BorderSide(color: Colors.blue),
								),
							),
						),

						//SPACING
						SizedBox(height: 10.0),

						// BUTTON
						Visibility(
							//visible: _canShowLoginForm,
							child: FlatButton(
								color: Colors.white,
								onPressed: hideButton,
								child: Text(mode),
								shape: RoundedRectangleBorder(
									borderRadius: BorderRadius.circular(36.0),
									side: BorderSide(color: Colors.blue),
								),
							),
						),

						Visibility(
							visible: _canShowRegisterForm,
							child: Text(
									_validation
								),
						),

					],
				),
			)
		);
	}
}
