import 'package:flutter/material.dart';
import 'package:rpg_app/domain/entities/anao.dart';
import 'package:rpg_app/domain/entities/arqueiro.dart';
import 'package:rpg_app/domain/entities/arquetipo.dart';
import 'package:rpg_app/domain/entities/elfo.dart';
import 'package:rpg_app/domain/entities/guerreiro.dart';
import 'package:rpg_app/domain/entities/heroi.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _imgHeroi = 'personagens/dwarf/dwarf_mage.png';
  final List<Raca> _racas = [
    Humano(bonusVida: 10, bonusEscudo: 10, bonusAtaque: 10),
    Orc(bonusVida: 14, bonusEscudo: 6, bonusAtaque: 10),
    Elfo(bonusVida: 6, bonusEscudo: 8, bonusAtaque: 16),
    Anao(bonusVida: 12, bonusEscudo: 6, bonusAtaque: 12),
  ];
  final List<Arquetipo> _arquetipos = [
    Guerreiro(bonusVida: 8, bonusEscudo: 8, bonusAtaque: 14),
    Arqueiro(bonusVida: 5, bonusEscudo: 5, bonusAtaque: 20),
    Mago(bonusVida: 5, bonusEscudo: 10, bonusAtaque: 15),
  ];

  late Raca _racaSelecionada;
  late Arquetipo _arquetipoSelecionado;
  int _pontosDisponiveis = 30;
  int _pontosVida = 0;
  int _pontosEscudo = 0;
  int _pontosVelocidade = 0;
  String _nome = '';
  String _reino = '';
  String _missao = '';
  bool _pointsWithError = false;

  @override
  void initState() {
    _racaSelecionada = _racas[0];
    _arquetipoSelecionado = _arquetipos[0];
    _trocarImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de herois')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildForm(),
                SizedBox(height: 10),
                Image.asset(_imgHeroi, height: 300, fit: BoxFit.contain),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: DropdownMenu<Raca>(
                        expandedInsets: EdgeInsets.zero,
                        initialSelection: _racaSelecionada,
                        dropdownMenuEntries: _buildMenuItensRaca(),
                        label: Text('Raça'),
                        onSelected: (raca) {
                          if (raca != null) {
                            _racaSelecionada = raca;
                            _trocarImage();
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownMenu<Arquetipo>(
                        expandedInsets: EdgeInsets.zero,
                        initialSelection: _arquetipoSelecionado,
                        dropdownMenuEntries: _buildMenuItensArquetipo(),
                        label: Text('Arquetipo'),
                        onSelected: (arquetipo) {
                          if (arquetipo != null) {
                            _arquetipoSelecionado = arquetipo;
                            _trocarImage();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text('Pontos disponíveis: $_pontosDisponiveis'),
                _buildErrorPointsMessage(),
                Column(
                  children: [
                    ListTile(
                      leading: IconButton(
                        onPressed: _minusVida,
                        icon: Icon(Icons.exposure_minus_1),
                      ),
                      trailing: IconButton(
                        onPressed: _addVida,
                        icon: Icon(Icons.plus_one),
                      ),
                      title: Text('Pontos de vida: $_pontosVida'),
                      subtitle: _buildBar(_pontosDisponiveis, _pontosVida),
                    ),
                    Divider(),
                    ListTile(
                      leading: IconButton(
                        onPressed: _minusEscudo,
                        icon: Icon(Icons.exposure_minus_1),
                      ),
                      trailing: IconButton(
                        onPressed: _addEscudo,
                        icon: Icon(Icons.plus_one),
                      ),
                      title: Text('Pontos de escudo: $_pontosEscudo'),
                      subtitle: _buildBar(_pontosDisponiveis, _pontosEscudo),
                    ),
                    Divider(),
                    ListTile(
                      leading: IconButton(
                        onPressed: _minusVelocidade,
                        icon: Icon(Icons.exposure_minus_1),
                      ),
                      trailing: IconButton(
                        onPressed: _addVelocidade,
                        icon: Icon(Icons.plus_one),
                      ),
                      title: Text('Pontos de velocidade: $_pontosVelocidade'),
                      subtitle: _buildBar(
                        _pontosDisponiveis,
                        _pontosVelocidade,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    final isValid = _formKey.currentState?.validate() ?? false;
                    setState(() {
                      _pointsWithError = _pontosDisponiveis > 0;
                    });
                    if (isValid) {
                      _formKey.currentState?.save();
                      final newHeroi = Heroi(
                        reino: _reino,
                        missao: _missao,
                        nome: _nome,
                        vida: _pontosVida,
                        escudo: _pontosEscudo,
                        velocidade: _pontosVelocidade,
                        raca: _racaSelecionada,
                      );
                      print(newHeroi);
                    }
                  },
                  child: Text('Salvar'),
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

  void _addVida() {
    setState(() {
      if (_pontosDisponiveis > 0) {
        _pontosDisponiveis--;
        _pontosVida++;
      }
    });
  }

  void _minusVida() {
    setState(() {
      if (_pontosVida > 0) {
        _pontosVida--;
        _pontosDisponiveis++;
      }
    });
  }

  void _addEscudo() {
    setState(() {
      if (_pontosDisponiveis > 0) {
        _pontosDisponiveis--;
        _pontosEscudo++;
      }
    });
  }

  void _minusEscudo() {
    setState(() {
      if (_pontosEscudo > 0) {
        _pontosEscudo--;
        _pontosDisponiveis++;
      }
    });
  }

  void _addVelocidade() {
    setState(() {
      if (_pontosDisponiveis > 0) {
        _pontosDisponiveis--;
        _pontosVelocidade++;
      }
    });
  }

  void _minusVelocidade() {
    setState(() {
      if (_pontosVelocidade > 0) {
        _pontosVelocidade--;
        _pontosDisponiveis++;
      }
    });
  }

  Widget _buildBar(int valorTotal, int valorAtual) {
    final percentual = valorAtual / valorTotal;
    return LinearProgressIndicator(value: percentual);
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nome',
            ),
            validator: (valor) {
              if (valor == null || valor.isEmpty) {
                return 'Nome é obrigatório';
              }
              return null;
            },
            onSaved: (valor) {
              if (valor != null) {
                _nome = valor;
              }
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Reino',
            ),
            validator: (valor) {
              if (valor == null || valor.isEmpty) {
                return 'Reino é obrigatório';
              }
              return null;
            },
            onSaved: (valor) {
              if (valor != null) {
                _reino = valor;
              }
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Missão',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Missão é obrigatória';
              }
              return null;
            },
            onSaved: (valor) {
              if (valor != null) {
                _missao = valor;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildErrorPointsMessage() {
    if (_pointsWithError) {
      return Text(
        'Você possui pontos para distribuir',
        style: TextStyle(color: Colors.red),
      );
    }
    return SizedBox.shrink();
  }
}
