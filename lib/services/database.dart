import 'package:amo/models/amomodel.dart';
import 'package:amo/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

	final String uid;
	DatabaseService ({ this.uid });

	final CollectionReference amoCollection = Firestore.instance.collection('amo');

	Future<void> updateUserData(String firstname, String lastname, String role, String email, String location) async {
		return await amoCollection.document(uid).setData({
			'firstname': firstname,
			'lastname': lastname,
			'role': role,
			'email': email,
			'location': location,
		});
	}

	Future<void> updateUserDataLocation(String firstname, String lastname, String role, String email, String location) async {
		return await amoCollection.document(uid).setData({
			'firstname': firstname,
			'lastname': lastname,
			'role': role,
			'email': email,
			'location': location,
		});
	}

	//data list from snapshot
	List<AmoModel> _dataListFromSnapshot(QuerySnapshot snapshot){
		return snapshot.documents.map((doc){
			return AmoModel(
				firstname: doc.data['firstname'] ?? '',
				lastname: doc.data['lastname'] ?? '',
				role: doc.data['role'] ?? '',
				email: doc.data['email'] ?? '',
				location: doc.data['location'] ?? '',
				//birthdate: doc.data['birthdate'] ?? 0
			);
		}).toList();
	}

	UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
		return UserData(
			uid: uid,
			firstname: snapshot.data['firstname'],
			lastname: snapshot.data['lastname'],
			role: snapshot.data['role'],
			email: snapshot.data['email'],
			location: snapshot.data['location'],
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