class UserModel {
  UserModel({
    required this.data,
    required this.support,
  });

  Data data;
  Support support;
}

class Data {
  Data({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;
}

class Support {
  Support({
    required this.url,
    required this.text,
  });

  String url;
  String text;
}
