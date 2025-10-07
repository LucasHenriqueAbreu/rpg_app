import 'package:rpg_app/domain/entities/personagem.dart';

class Monstro extends Personagem {
  final String _origem;
  final String _tipoCriatura;

  Monstro({
    required String origem,
    required String tipoCriatura,
    required super.nome,
    required super.vida,
    required super.escudo,
    required super.velocidade,
    required super.raca,
  }) : _origem = origem,
       _tipoCriatura = tipoCriatura;
}
