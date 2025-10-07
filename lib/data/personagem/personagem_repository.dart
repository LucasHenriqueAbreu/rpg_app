import 'package:rpg_app/domain/entities/personagem.dart';

class PersonagemRepository {
  final List<Personagem> _data = [];

  List<Personagem> list() {
    return _data;
  }

  void adicionar(Personagem personagem) {
    _data.add(personagem);
  }
}
