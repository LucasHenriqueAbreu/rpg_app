abstract class Arquetipo {
  final int _bonusVida;
  final int _bonusEscudo;
  final int _bonusAtaque;

  Arquetipo({
    required int bonusVida,
    required int bonusEscudo,
    required int bonusAtaque,
  }) : _bonusVida = bonusVida,
       _bonusEscudo = bonusEscudo,
       _bonusAtaque = bonusAtaque;

  int get bonusVida => _bonusVida;
  int get bonusEscudo => _bonusEscudo;
  int get bonusAtaque => _bonusAtaque;

  String getName();
}
