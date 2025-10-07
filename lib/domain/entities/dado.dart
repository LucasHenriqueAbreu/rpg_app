import 'dart:math';

class Dado {
  final int _lados;
  Dado(this._lados);

  int get lados => _lados;

  int jogarDado() {
    return Random().nextInt(_lados) + 1;
  }
}
