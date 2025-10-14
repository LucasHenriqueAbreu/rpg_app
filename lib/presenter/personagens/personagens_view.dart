import 'package:flutter/material.dart';
import 'package:rpg_app/domain/entities/anao.dart';
import 'package:rpg_app/domain/entities/humano.dart';
import 'package:rpg_app/domain/entities/monstro.dart';
import 'package:rpg_app/domain/entities/personagem.dart';
import 'package:rpg_app/presenter/personagens/cadastro_personagem_view.dart';

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
    return Scaffold(
      body: _construirLista(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroPersonagemView()),
          );
        },
      ),
    );
  }

  ListView _construirLista() {
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
