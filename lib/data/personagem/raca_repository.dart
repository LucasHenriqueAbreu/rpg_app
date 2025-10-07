import 'package:rpg_app/domain/entities/anao.dart';
import 'package:rpg_app/domain/entities/elfo.dart';
import 'package:rpg_app/domain/entities/humano.dart';
import 'package:rpg_app/domain/entities/orc.dart';
import 'package:rpg_app/domain/entities/raca.dart';

class RacaRepository {
  final List<Raca> _data = [
    Humano(
      bonusVida: 10, // Equilibrado
      bonusEscudo: 10,
      bonusAtaque: 10,
    ),
    Anao(
      bonusVida: 14, // Mais vida e escudo, menos ataque
      bonusEscudo: 12,
      bonusAtaque: 4,
    ),
    Orc(
      bonusVida: 12, // Mais ataque, menos escudo
      bonusEscudo: 6,
      bonusAtaque: 12,
    ),
    Elfo(
      bonusVida: 8, // Mais ataque e escudo, menos vida
      bonusEscudo: 12,
      bonusAtaque: 10,
    ),
  ];

  List<Raca> list() {
    return _data;
  }
}
