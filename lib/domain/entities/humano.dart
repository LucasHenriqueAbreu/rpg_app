import 'package:rpg_app/domain/entities/raca.dart';

class Humano extends Raca {
  Humano({
    required super.bonusVida,
    required super.bonusEscudo,
    required super.bonusAtaque,
  });

  @override
  String getName() {
    return 'Humano';
  }
}
