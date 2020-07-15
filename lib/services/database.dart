import 'package:amo/models/amomodel.dart';
import 'package:amo/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

	final String uid;
	DatabaseService ({ this.uid });

	final CollectionReference amoCollection = Firestore.instance.collection('amo');

	/*Future updateUserData(String firstname, String lastname) async {  //int birthdate) async {

		return await amoCollection.document(uid).setData({
			'firstname': firstname,
			'lastname': lastname,
			//'birthdate': birthdate,
		});
	}*/

	Future<void> updateUserData(String firstname, String lastname) async {
		return await amoCollection.document(uid).setData({
			'firstname': firstname,
			'lastname': lastname,
		});
	}

	//data list from snapshot
	List<AmoModel> _dataListFromSnapshot(QuerySnapshot snapshot){
		return snapshot.documents.map((doc){
			return AmoModel(
				firstname: doc.data['firstname'] ?? '',
				lastname: doc.data['lastname'] ?? '',
				//birthdate: doc.data['birthdate'] ?? 0
			);
		}).toList();
	}

	UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
		return UserData(
			uid: uid,
			firstname: snapshot.data['firstname'],
			lastname: snapshot.data['lastname'],
		);
	}

	//get data stream
	Stream<List<AmoModel>> get amo {
		return amoCollection.snapshots()
			.map(_dataListFromSnapshot);
	}

	Stream<UserData> get userData {
		return amoCollection.document(uid).snapshots()
		.map(_userDataFromSnapshot);
	}

}