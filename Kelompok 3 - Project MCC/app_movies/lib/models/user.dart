class User {
  int id;
  String username;
  String email;
  String password;
  String token;

  User(
      {required this.id,
      required this.email,
      required this.username,
      required this.password,
      required this.token});

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      username: json['username'],
      email: json['email'],
      password: json['password'],
      token: json['token']);
}
