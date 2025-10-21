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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              viewModel.imagemPersonagem,
              key: ValueKey(viewModel.imagemPersonagem),
              height: 180,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<Raca>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Raça',
              ),
              value: viewModel.racaSelecionada,
              isExpanded: true,
              hint: const Text('Escolha uma raça'),
              items: racas
                  .map(
                    (raca) => DropdownMenuItem<Raca>(
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
            const SizedBox(height: 16),
            DropdownButtonFormField<Arquetipo>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Arquétipo',
              ),
              value: viewModel.arquetipoSelecionado,
              isExpanded: true,
              hint: const Text('Escolha um arquétipo'),
              items: arquetipos
                  .map(
                    (arquetipo) => DropdownMenuItem<Arquetipo>(
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
            const SizedBox(height: 32),
            Text(
              'Distribua ${viewModel.pontosTotais} pontos entre Vida, Escudo e Velocidade.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              viewModel.pontosRestantes > 0
                  ? 'Pontos restantes: ${viewModel.pontosRestantes}'
                  : 'Todos os pontos foram distribuídos.',
              style: TextStyle(
                color: viewModel.pontosRestantes > 0
                    ? Colors.orange[700]
                    : Colors.green[700],
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            _DistribuicaoAtributo(
              titulo: 'Vida',
              base: viewModel.vidaBase,
              bonusRaca: viewModel.bonusVidaRaca,
              bonusArquetipo: viewModel.bonusVidaArquetipo,
              podeIncrementar: viewModel.pontosRestantes > 0,
              podeDecrementar: viewModel.vidaBase > 0,
              pontosTotais: viewModel.pontosTotais,
              onIncrement: () => viewModel.ajustarVida(1),
              onDecrement: () => viewModel.ajustarVida(-1),
            ),
            _DistribuicaoAtributo(
              titulo: 'Escudo',
              base: viewModel.escudoBase,
              bonusRaca: viewModel.bonusEscudoRaca,
              bonusArquetipo: viewModel.bonusEscudoArquetipo,
              podeIncrementar: viewModel.pontosRestantes > 0,
              podeDecrementar: viewModel.escudoBase > 0,
              pontosTotais: viewModel.pontosTotais,
              onIncrement: () => viewModel.ajustarEscudo(1),
              onDecrement: () => viewModel.ajustarEscudo(-1),
            ),
            _DistribuicaoAtributo(
              titulo: 'Velocidade',
              base: viewModel.velocidadeBase,
              bonusRaca: viewModel.bonusVelocidadeRaca,
              bonusArquetipo: viewModel.bonusVelocidadeArquetipo,
              podeIncrementar: viewModel.pontosRestantes > 0,
              podeDecrementar: viewModel.velocidadeBase > 0,
              pontosTotais: viewModel.pontosTotais,
              onIncrement: () => viewModel.ajustarVelocidade(1),
              onDecrement: () => viewModel.ajustarVelocidade(-1),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final raca = viewModel.racaSelecionada;
                final arquetipo = viewModel.arquetipoSelecionado;

                if (raca == null || arquetipo == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Selecione uma raça e um arquétipo.'),
                    ),
                  );
                  return;
                }

                if (!viewModel.pontosDistribuidos) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Distribua todos os pontos antes de criar o personagem.'),
                    ),
                  );
                  return;
                }

                final novoHeroi = Heroi(
                  nome: 'Novo Herói',
                  vida: viewModel.vidaBase + viewModel.bonusVidaArquetipo,
                  escudo: viewModel.escudoBase + viewModel.bonusEscudoArquetipo,
                  velocidade: viewModel.velocidadeBase +
                      viewModel.bonusVelocidadeRaca +
                      viewModel.bonusVelocidadeArquetipo,
                  raca: raca,
                  arquetipo: arquetipo,
                  reino: 'Reino X',
                  missao: 'Salvar o mundo',
                );

                viewModel.create(novoHeroi);
                Navigator.pop(context);
              },
              child: const Text('Criar Personagem'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DistribuicaoAtributo extends StatelessWidget {
  final String titulo;
  final int base;
  final int bonusRaca;
  final int bonusArquetipo;
  final int pontosTotais;
  final bool podeIncrementar;
  final bool podeDecrementar;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _DistribuicaoAtributo({
    required this.titulo,
    required this.base,
    required this.bonusRaca,
    required this.bonusArquetipo,
    required this.pontosTotais,
    required this.podeIncrementar,
    required this.podeDecrementar,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final total = base + bonusRaca + bonusArquetipo;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tema.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tema.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titulo,
                style: tema.textTheme.titleMedium,
              ),
              Text(
                '$total pts',
                style: tema.textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final larguraTotal = constraints.maxWidth;
              final maximo = pontosTotais <= 0 ? 1 : pontosTotais;
              var restante = 1.0;
              final baseFracao =
                  (base / maximo).clamp(0.0, restante);
              restante -= baseFracao;
              final bonusRacaFracao =
                  (bonusRaca / maximo).clamp(0.0, restante);
              restante -= bonusRacaFracao;
              final bonusArquetipoFracao =
                  (bonusArquetipo / maximo).clamp(0.0, restante);

              final larguraBase = larguraTotal * baseFracao;
              final larguraBonusRaca = larguraTotal * bonusRacaFracao;
              final larguraBonusArquetipo = larguraTotal * bonusArquetipoFracao;

              return SizedBox(
                height: 16,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: tema.colorScheme.surfaceVariant.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    if (base > 0)
                      Positioned(
                        left: 0,
                        child: Container(
                          width: larguraBase,
                          decoration: BoxDecoration(
                            color: tema.colorScheme.primary.withOpacity(0.75),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    if (bonusRaca > 0)
                      Positioned(
                        left: larguraBase,
                        child: Container(
                          width: larguraBonusRaca,
                          decoration: BoxDecoration(
                            color:
                                tema.colorScheme.tertiaryContainer.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    if (bonusArquetipo > 0)
                      Positioned(
                        left: larguraBase + larguraBonusRaca,
                        child: Container(
                          width: larguraBonusArquetipo,
                          decoration: BoxDecoration(
                            color: tema.colorScheme.secondary.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              _LegendaChaveValor(
                titulo: 'Base',
                valor: base,
                cor: tema.colorScheme.primary.withOpacity(0.75),
              ),
              _LegendaChaveValor(
                titulo: 'Raça',
                valor: bonusRaca,
                cor: tema.colorScheme.tertiaryContainer.withOpacity(0.9),
                prefixo: '+',
              ),
              _LegendaChaveValor(
                titulo: 'Arquétipo',
                valor: bonusArquetipo,
                cor: tema.colorScheme.secondary.withOpacity(0.85),
                prefixo: '+',
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: podeDecrementar ? onDecrement : null,
                icon: const Icon(Icons.remove_circle_outline),
                tooltip: 'Diminuir $titulo',
              ),
              Text(
                '$base pts base',
                style: tema.textTheme.titleMedium,
              ),
              IconButton(
                onPressed: podeIncrementar ? onIncrement : null,
                icon: const Icon(Icons.add_circle_outline),
                tooltip: 'Aumentar $titulo',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendaChaveValor extends StatelessWidget {
  final String titulo;
  final int valor;
  final Color cor;
  final String prefixo;

  const _LegendaChaveValor({
    required this.titulo,
    required this.valor,
    required this.cor,
    this.prefixo = '',
  });

  @override
  Widget build(BuildContext context) {
    final brilho = ThemeData.estimateBrightnessForColor(cor);
    final textoCor =
        brilho == Brightness.dark ? Colors.white : Colors.black87;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: cor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$titulo $prefixo$valor',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: textoCor,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
