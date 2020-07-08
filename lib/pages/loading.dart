import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class Loading extends StatefulWidget {
	@override
	_LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

	@override
	void initState() {
		super.initState();
	}

	void setUp() async{

		Navigator.pushReplacementNamed(context, '/choose_mode');

	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.blue,

			body: Center(

				child: SpinKitHourGlass(
					color: Colors.white,
					size: 50.0,
				),
			),
		);
	}
}
