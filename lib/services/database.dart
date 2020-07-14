import 'package:amo/models/amomodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

	final String uid;
	DatabaseService ({ this.uid });

	final CollectionReference amoCollection = Firestore.instance.collection('amo');

	Future updateUserData(String firstname, String lastname, int birthdate) async {

		return await amoCollection.document(uid).setData({
			'firstname': firstname,
			'lastname': lastname,
			'birthdate': birthdate,
		});
	}

	//data list from snapshot
	List<AmoModel> _dataListFromSnapshot(QuerySnapshot snapshot){
		return snapshot.documents.map((doc){
			return AmoModel(
				firstname: doc.data['firstname'] ?? '',
				lastname: doc.data['lastname'] ?? '',
				birthdate: doc.data['birthdate'] ?? 0
			);
		}).toList();
	}

	//get data stream
	Stream<List<AmoModel>> get amo {
		return amoCollection.snapshots()
			.map(_dataListFromSnapshot);
	}

}