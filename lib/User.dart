class User {
  late String _nome;
  late String _email;
  String _curso;
  String _foto;
  late int _ano;
  late int _ects;

  User(this._nome, this._email, this._curso, this._foto, this._ano, this._ects);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['nome'],
      json['email'],
      json['curso'],
      json['foto'],
      json['ano'],
      json['ects'],
    );
  }

  int get ects => _ects;

  set ects(int value) {
    _ects = value;
  }

  int get ano => _ano;

  set ano(int value) {
    _ano = value;
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
