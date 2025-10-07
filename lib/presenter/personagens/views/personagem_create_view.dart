import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpg_app/domain/entities/arquetipo.dart';
import 'package:rpg_app/domain/entities/heroi.dart';
import 'package:rpg_app/domain/entities/raca.dart';
import 'package:rpg_app/presenter/personagens/view_model/personagens_viewmodel.dart';

class PersonagemCreateView extends StatelessWidget {
  const PersonagemCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PersonagensViewmodel>();
    final racas = viewModel.racasDisponiveis;
    final arquetipos = viewModel.arquetiposDisponiveis;

    return Scaffold(
      appBar: AppBar(title: const Text('Criar Personagem')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(
              viewModel.imagemPersonagem,
              height: 180,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            DropdownButton<Raca>(
              isExpanded: true,
              value: viewModel.racaSelecionada,
              hint: const Text('Escolha uma raça'),
              items:
                  racas
                      .map(
                        (raca) => DropdownMenuItem(
                          value: raca,
                          child: Text(raca.runtimeType.toString()),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                if (value != null) {
                  viewModel.setRaca(value);
                }
              },
            ),
            const SizedBox(height: 8),
            DropdownButton<Arquetipo>(
              isExpanded: true,
              value: viewModel.arquetipoSelecionado,
              hint: const Text('Escolha um arquétipo'),
              items:
                  arquetipos
                      .map(
                        (arquetipo) => DropdownMenuItem(
                          value: arquetipo,
                          child: Text(arquetipo.runtimeType.toString()),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                if (value != null) {
                  viewModel.setArquetipo(value);
                }
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final raca = viewModel.racaSelecionada;
                final arquetipo = viewModel.arquetipoSelecionado;
                if (raca != null && arquetipo != null) {
                  final novo = Heroi(
                    nome: 'Novo Heroi',
                    vida: 100,
                    escudo: 100,
                    velocidade: 100,
                    raca: raca,
                    arquetipo: arquetipo,
                    reino: 'Reino X',
                    missao: 'Salvar o mundo',
                  );
                  viewModel.create(novo);
                  Navigator.pop(context);
                }
              },
              child: const Text('Criar Personagem'),
            ),
          ],
        ),
      ),
    );
  }
}
