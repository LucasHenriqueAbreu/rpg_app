import 'package:flutter/material.dart';
import 'package:rpg_app/domain/entities/anao.dart';
import 'package:rpg_app/domain/entities/elfo.dart';
import 'package:rpg_app/domain/entities/humano.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de herois')),
      body: Column(
        children: [
          Image.asset(_imgHeroi),
          DropdownButton(
            items: _buildMenuItemsRaca(),
            onChanged: (raca) {
              _racaSelecionada = raca;
              _trocarImage();
            },
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<Raca>> _buildMenuItemsRaca() {
    return _racas
        .map(
          (raca) =>
              DropdownMenuItem(value: raca, child: Text(_getRacaName(raca))),
        )
        .toList();
  }

  String _getRacaName(Raca raca) {
    if (raca is Humano) {
      return 'Humano';
    }
    if (raca is Orc) {
      return 'Orc';
    }
    if (raca is Elfo) {
      return 'Elfo';
    }
    return 'Anão';
  }

  void _trocarImage() {
    setState(() {
      _imgHeroi = _getImage();
    });
  }

  String _getImage() {
    if (_racaSelecionada is Humano) {
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
}
