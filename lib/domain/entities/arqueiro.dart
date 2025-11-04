import 'package:rpg_app/domain/entities/arquetipo.dart';

class Arqueiro extends Arquetipo {
  Arqueiro({
    required super.bonusVida,
    required super.bonusEscudo,
    required super.bonusAtaque,
  });

  @override
  String getName() {
    return 'Arqueiro';
  }
}
