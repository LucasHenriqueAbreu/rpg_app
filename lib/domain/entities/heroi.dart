import 'package:rpg_app/domain/entities/personagem.dart';

class Heroi extends Personagem {
  final String _reino;
  final String _missao;

  Heroi({
    required String reino,
    required String missao,
    required super.nome,
    required super.vida,
    required super.escudo,
    required super.velocidade,
    required super.raca,
    required super.arquetipo,
  }) : _reino = reino,
       _missao = missao;

  String get reino => _reino;
  String get missao => _missao;

  @override
  String descricao() => 'Herói do reino $_reino em missão: $_missao';
}
