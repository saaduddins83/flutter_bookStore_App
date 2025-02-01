class UserModel {
  String? username;
  String? id;
  String? email;

  UserModel({this.username, this.email, this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    id = json['uid'];
    email = json['email'];
  }
//Method to convert Firestore Document to model
  factory UserModel.fromFirestore(
      Map<String, dynamic> data, String documentId) {
    return UserModel(
      id: documentId,
      username: data['username'] ?? '',
      email: data['email'] ?? '',
    );
  }

  //Method to convert model to Firestore Document
  Map<String, dynamic> toFirestore() {
    return {
      'username': username,
      'email': email,
    };
  }
}
