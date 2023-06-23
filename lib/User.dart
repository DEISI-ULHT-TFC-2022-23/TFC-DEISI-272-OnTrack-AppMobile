class User {
  late int _id;
  late String _nome;
  late String _email;
  String _curso;
  String _foto;
  late String _codigo;

  User(this._id, this._nome, this._email, this._curso, this._foto, this._codigo);

  factory User.fromJson(Map<String, dynamic> json) {
    String foto = "images/avatar.jpg";
    String curso = json['curso']['nome'];
    String codigo = json['curso']['codigo'];
    return User(
      json['id'],
      json['nome'],
      json['email'],
      curso,
      foto,
      codigo,
    );
  }


  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get codigo => _codigo;

  set codigo(String value) {
    _codigo = value;
  }

  String get foto => _foto;

  set foto(String value) {
    _foto = value;
  }

  String get curso => _curso;

  set curso(String value) {
    _curso = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }
}
