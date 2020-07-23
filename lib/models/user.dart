class User{
	final String uid;

	User({ this.uid });
}

class UserData{
	final String uid;
	final String firstname;
	final String lastname;
	final String role;
	final String email;
	final String location;

	UserData({ this.uid, this.firstname, this.lastname, this.role, this.email, this.location});
}