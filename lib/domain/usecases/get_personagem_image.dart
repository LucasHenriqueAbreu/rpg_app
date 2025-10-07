import 'package:rpg_app/domain/entities/arqueiro.dart';
import 'package:rpg_app/domain/entities/arquetipo.dart';
import 'package:rpg_app/domain/entities/guerreiro.dart';
import 'package:rpg_app/domain/entities/mago.dart';
import 'package:rpg_app/domain/entities/raca.dart';
import 'package:rpg_app/domain/entities/humano.dart';
import 'package:rpg_app/domain/entities/elfo.dart';
import 'package:rpg_app/domain/entities/orc.dart';
import 'package:rpg_app/domain/entities/anao.dart';

class GetPersonagemImageUsecase {
  static String execute(Raca? raca, Arquetipo? arquetipo) {
    final folder = _getFolderName(raca);
    final suffix = _getSuffix(arquetipo);
    return 'personagens/$folder/$folder$suffix.png';
  }

  static String _getFolderName(Raca? raca) {
    if (raca is Humano) {
      return 'human';
    }
    if (raca is Elfo) {
      return 'elf';
    }
    if (raca is Orc) {
      return 'orc';
    }
    if (raca is Anao) {
      return 'dwarf';
    }
    return 'human';
  }

  static String _getSuffix(Arquetipo? arquetipo) {
    if (arquetipo is Guerreiro) {
      return '_warrior';
    }
    if (arquetipo is Mago) {
      return '_mage';
    }
    if (arquetipo is Arqueiro) {
      return '_archer';
    }
    return '_neutral';
  }
}
