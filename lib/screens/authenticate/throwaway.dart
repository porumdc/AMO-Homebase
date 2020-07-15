/*


							),
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

										TextFormField( //First name
											decoration: textInputDecoration.copyWith(hintText: 'First name'),
											controller: _firstName,
											validator: (valFirstName) => valFirstName.isEmpty ? 'Enter first name.' : null,
											onChanged: (valFirstName) {
												setState(() => firstName = valFirstName);
											}
										),

										SizedBox(height: 20.0),

										TextFormField( //Last name
											decoration: textInputDecoration.copyWith(hintText: 'Last name'),
											controller: _lastName,
											validator: (valLastName) => valLastName.isEmpty ? 'Enter last name.' : null,
											onChanged: (valLastName) {
												setState(() => lastName = valLastName);
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
													setState(() => loading = true);	
													dynamic result = await _auth.registerWithEmailAndPassword(email, password); //, firstName, lastName);

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
								),*/