import 'package:rpg_app/domain/entities/dado.dart';
import 'package:rpg_app/domain/entities/personagem.dart';

class Duelo {
  final Personagem _jogador1;
  final Personagem _jogador2;
  final Dado _dado;
  Personagem? _atacante;
  Personagem? _defensor;

  Duelo({
    required Personagem jogador1,
    required Personagem jogador2,
    required Dado dado,
  }) : _jogador1 = jogador1,
       _jogador2 = jogador2,
       _dado = dado;

  Personagem? get jogadorVez => _atacante;
  Personagem? get oponente => _defensor;

  void iniciar() {
    _definirPosicaoInicial();
    if (_atacante != null && _defensor != null) {
      while (_jogador1.estaVivo() && _jogador2.estaVivo()) {
        final dano = _dado.jogarDado();
        print('Jogador vez: ${_atacante!.nome}, dano: $dano');
        _atacante!.atacar(_defensor!, dano);
        _jogador1.exibirStatus();
        _jogador2.exibirStatus();
        if (_defensor!.estaVivo()) {
          _trocarPosicoes();
        }
      }
      _mostrarVencedor();
    }
  }

  void _setTurno({required Personagem atacante, required Personagem defensor}) {
    _atacante = atacante;
    _defensor = defensor;
  }

  void _definirPosicaoInicial() {
    if (_jogador1.velocidade >= _jogador2.velocidade) {
      _setTurno(atacante: _jogador1, defensor: _jogador2);
    } else {
      _setTurno(atacante: _jogador2, defensor: _jogador1);
    }
  }

  void _trocarPosicoes() {
    final atual = _atacante;
    _atacante = _defensor;
    _defensor = atual;
  }

  void _mostrarVencedor() {
    final vencedor = _jogador1.estaVivo() ? _jogador1 : _jogador2;
    print('O jogador ${vencedor.nome}, venceu!!');
  }
}
