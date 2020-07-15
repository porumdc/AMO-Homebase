/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amo/models/amomodel.dart';
import 'package:amo/screens/home/datatile.dart';

class AmoDataList extends StatefulWidget{
	@override
	_AmoDataListState createState() => _AmoDataListState();
}

class _AmoDataListState extends State<AmoDataList>{
	@override
	Widget build(BuildContext context){

		final dataProvider = Provider.of<List<AmoModel>>(context);

		/*return Scaffold(
			body: Container(
				child: Text('H E N LO'),
			),
		);*/

		return ListView.builder(
			itemCount: dataProvider.length,
			itemBuilder: (context, index){
				return DataTile(amomodel: dataProvider[index]);
			},
		);
	}
}*/