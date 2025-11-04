import 'package:rpg_app/domain/entities/arquetipo.dart';

class Mago extends Arquetipo {
  Mago({
    required super.bonusVida,
    required super.bonusEscudo,
    required super.bonusAtaque,
  });

  @override
  String getName() {
    return 'Mago';
  }
}
