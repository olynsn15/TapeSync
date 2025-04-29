class User {
  int id;
  String username;
  String password;
  String role;
  String token;

  User(
      {required this.id,
      required this.role,
      required this.username,
      required this.password,
      required this.token});

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      username: json['admin_name'],
      role: json['role'],
      password: json['admin_password'],
      token: json['token']);
}
