import 'package:flutter/material.dart';
import 'package:rpg_app/domain/entities/anao.dart';
import 'package:rpg_app/domain/entities/humano.dart';
import 'package:rpg_app/domain/entities/monstro.dart';
import 'package:rpg_app/domain/entities/personagem.dart';

class PersonagensView extends StatelessWidget {
  PersonagensView({super.key});

  final List<Personagem> _personagens = [
    Monstro(
      origem: 'Cuiabá',
      tipoCriatura: 'Satanás',
      nome: 'João',
      vida: 100,
      escudo: 100,
      velocidade: 100,
      raca: Anao(bonusAtaque: 100, bonusEscudo: 100, bonusVida: 100),
    ),
    Monstro(
      origem: 'Cuiabá',
      tipoCriatura: 'Satanás',
      nome: 'João 2',
      vida: 100,
      escudo: 100,
      velocidade: 100,
      raca: Humano(bonusAtaque: 100, bonusEscudo: 100, bonusVida: 100),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _personagens.length,
      itemBuilder: (context, index) {
        final personagem = _personagens[index];
        return ListTile(
          title: Text('Teste ${personagem.nome}'),
          subtitle: Text('Eu sou um subtítulo'),
        );
      },
    );
  }
}
