class UserModel {
  String? username;
  String? id;
  String? email;

  UserModel({this.username, this.email, this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    id = json['id'];
    email = json['email'];
  }
}
