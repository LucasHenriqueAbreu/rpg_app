import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpg_app/domain/entities/heroi.dart';
import 'package:rpg_app/domain/entities/monstro.dart';
import 'package:rpg_app/domain/entities/personagem.dart';
import 'package:rpg_app/presenter/personagens/view_model/personagens_viewmodel.dart';

class PersonagensListView extends StatefulWidget {
  const PersonagensListView({super.key});

  @override
  State<PersonagensListView> createState() => _PersonagensListViewState();
}

class _PersonagensListViewState extends State<PersonagensListView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_carregarDados);
  }

  void _carregarDados() {
    final viewModel = context.read<PersonagensViewmodel>();
    viewModel.carregarPersonagens();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PersonagensViewmodel>();
    final personagens = viewModel.personagens;

    if (personagens.isEmpty) {
      return const Center(child: Text('Nenhum personagem encontrado.'));
    }

    return ListView.builder(
      itemCount: personagens.length,
      itemBuilder: (context, index) => _buildCard(personagens[index]),
    );
  }

  Widget _buildCard(Personagem personagem) {
    final Icon icon = _iconePersonagem(personagem);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      child: ListTile(
        leading: icon,
        title: Text(
          personagem.nome,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(personagem.descricao()),
            Text(
              'Vida: ${personagem.vida} | Escudo: ${personagem.escudo} | Velocidade: ${personagem.velocidade}',
            ),
          ],
        ),
      ),
    );
  }

  Icon _iconePersonagem(Personagem personagem) {
    if (personagem is Heroi) {
      return const Icon(Icons.shield, color: Colors.blue);
    }
    if (personagem is Monstro) {
      return const Icon(Icons.pets, color: Colors.redAccent);
    }
    return const Icon(Icons.person, color: Colors.grey);
  }
}
