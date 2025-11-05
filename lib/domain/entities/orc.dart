import 'package:rpg_app/domain/entities/raca.dart';

class Orc extends Raca {
  Orc({
    required super.bonusVida,
    required super.bonusEscudo,
    required super.bonusAtaque,
  });

  @override
  String getName() {
    return 'Orc';
  }
}
