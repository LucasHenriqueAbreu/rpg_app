import 'package:rpg_app/domain/entities/Mago.dart';
import 'package:rpg_app/domain/entities/arqueiro.dart';
import 'package:rpg_app/domain/entities/arquetipo.dart';
import 'package:rpg_app/domain/entities/guerreiro.dart';

class ArquetipoRepository {
  final List<Arquetipo> _data = [
    Mago(
      bonusVida: 10, // Menos vida, mais ataque
      bonusEscudo: 8,
      bonusAtaque: 17,
    ),
    Arqueiro(
      bonusVida: 12, // Vida média, ataque equilibrado
      bonusEscudo: 10,
      bonusAtaque: 13,
    ),
    Guerreiro(
      bonusVida: 15, // Mais vida, menos ataque
      bonusEscudo: 12,
      bonusAtaque: 8,
    ),
  ];

  List<Arquetipo> list() {
    return _data;
  }
}
