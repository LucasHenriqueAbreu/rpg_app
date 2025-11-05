import 'package:rpg_app/domain/entities/raca.dart';

class Anao extends Raca {
  Anao({
    required super.bonusVida,
    required super.bonusEscudo,
    required super.bonusAtaque,
  });

  @override
  String getName() {
    return 'Anão';
  }
}
