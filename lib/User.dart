class User{
  late String _nome;
  late String _email;
  String _curso;
  String _foto;
  late int _ano;
  late int _ects;
  List _UnidadesCurriculares = [];
  List _EventosAvaliacao = [];

  User(this._nome, this._email, this._curso, this._foto, this._ano, this._ects);

  List get EventosAvaliacao => _EventosAvaliacao;

  set EventosAvaliacao(List value) {
    _EventosAvaliacao = value;
  }

  List get UnidadesCurriculares => _UnidadesCurriculares;

  set UnidadesCurriculares(List value) {
    _UnidadesCurriculares = value;
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