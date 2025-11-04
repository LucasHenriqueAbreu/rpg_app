import 'package:rpg_app/domain/entities/arquetipo.dart';

class Guerreiro extends Arquetipo {
  Guerreiro({
    required super.bonusVida,
    required super.bonusEscudo,
    required super.bonusAtaque,
  });

  @override
  String getName() {
    return 'Guerreiro';
  }
}
