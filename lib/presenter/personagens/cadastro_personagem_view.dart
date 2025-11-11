import 'package:flutter/material.dart';
import 'package:rpg_app/domain/entities/anao.dart';
import 'package:rpg_app/domain/entities/arqueiro.dart';
import 'package:rpg_app/domain/entities/arquetipo.dart';
import 'package:rpg_app/domain/entities/elfo.dart';
import 'package:rpg_app/domain/entities/guerreiro.dart';
import 'package:rpg_app/domain/entities/humano.dart';
import 'package:rpg_app/domain/entities/mago.dart';
import 'package:rpg_app/domain/entities/orc.dart';
import 'package:rpg_app/domain/entities/raca.dart';

class CadastroPersonagemView extends StatefulWidget {
  const CadastroPersonagemView({super.key});

  @override
  State<CadastroPersonagemView> createState() => _CadastroPersonagemViewState();
}

class _CadastroPersonagemViewState extends State<CadastroPersonagemView> {
  String _imgHeroi = 'personagens/dwarf/dwarf_mage.png';
  final List<Raca> _racas = [
    Humano(bonusVida: 10, bonusEscudo: 10, bonusAtaque: 10),
    Orc(bonusVida: 14, bonusEscudo: 6, bonusAtaque: 10),
    Elfo(bonusVida: 6, bonusEscudo: 8, bonusAtaque: 16),
    Anao(bonusVida: 12, bonusEscudo: 6, bonusAtaque: 12),
  ];
  Raca? _racaSelecionada;
  final List<Arquetipo> _arquetipos = [
    Guerreiro(bonusVida: 8, bonusEscudo: 8, bonusAtaque: 14),
    Arqueiro(bonusVida: 5, bonusEscudo: 5, bonusAtaque: 20),
    Mago(bonusVida: 5, bonusEscudo: 10, bonusAtaque: 15),
  ];
  Arquetipo? _arquetipoSelecionado;
  int _pontosDisponiveis = 30;
  int _pontosVida = 0;
  final int _pontosEscudo = 0;
  final int _pontosVelocidade = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de herois')),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(_imgHeroi, height: 300, fit: BoxFit.contain),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownMenu<Raca>(
                      initialSelection: _racas[0],
                      dropdownMenuEntries: _buildMenuItensRaca(),
                      label: Text('Raça'),
                      onSelected: (raca) {
                        _racaSelecionada = raca;
                        _trocarImage();
                      },
                    ),
                    SizedBox(width: 10),
                    DropdownMenu<Arquetipo>(
                      initialSelection: _arquetipos[0],
                      dropdownMenuEntries: _buildMenuItensArquetipo(),
                      label: Text('Arquetipo'),
                      onSelected: (arquetipo) {
                        _arquetipoSelecionado = arquetipo;
                        _trocarImage();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text('Pontos disponíveis: $_pontosDisponiveis'),
                Column(
                  children: [
                    ListTile(
                      trailing: IconButton(
                        onPressed: _addVida(),
                        icon: Icon(Icons.plus_one),
                      ),
                      title: Text('Pontos de vida: $_pontosVida'),
                      subtitle: Text('TODO: adicionar barra de progresso'),
                    ),
                    Divider(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuEntry<Raca>> _buildMenuItensRaca() {
    return _racas
        .map((raca) => DropdownMenuEntry(value: raca, label: raca.getName()))
        .toList();
  }

  List<DropdownMenuEntry<Arquetipo>> _buildMenuItensArquetipo() {
    return _arquetipos
        .map(
          (arquetipo) =>
              DropdownMenuEntry(value: arquetipo, label: arquetipo.getName()),
        )
        .toList();
  }

  void _trocarImage() {
    setState(() {
      _imgHeroi = _getImage();
    });
  }

  String _getImage() {
    if (_racaSelecionada is Humano) {
      if (_arquetipoSelecionado is Arqueiro) {
        return 'personagens/human/human_archer.png';
      }
      if (_arquetipoSelecionado is Mago) {
        return 'personagens/human/human_mage.png';
      }
      if (_arquetipoSelecionado is Guerreiro) {
        return 'personagens/human/human_warrior.png';
      }
      return 'personagens/human/human_neutral.png';
    }
    if (_racaSelecionada is Orc) {
      return 'personagens/orc/orc_neutral.png';
    }
    if (_racaSelecionada is Elfo) {
      return 'personagens/elf/elf_neutral.png';
    }
    return 'personagens/dwarf/dwarf_neutral.png';
  }

  _addVida() {
    setState(() {
      if (_pontosDisponiveis > 0) {
        _pontosDisponiveis--;
        _pontosVida++;
      }
    });
  }
}
