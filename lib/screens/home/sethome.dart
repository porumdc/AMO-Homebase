import 'package:amo/screens/home/amomemberlist.dart';
import 'package:amo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:amo/services/database.dart';
import 'package:provider/provider.dart';
import 'package:amo/models/amomodel.dart';
import 'package:amo/models/user.dart';

class SetHome extends StatefulWidget{
	@override
	_SetHomeState createState() => _SetHomeState();

}

class _SetHomeState extends State<SetHome> {

	@override
	Widget build(BuildContext context){


		return StreamProvider<List<AmoModel>>.value(
			value: DatabaseService().amo,
			child: AmoMemberList(),

		);
	}

}