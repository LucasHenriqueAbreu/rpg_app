import 'package:flutter/material.dart';
import 'package:rpg_app/presenter/arena/arena_view.dart';
import 'package:rpg_app/presenter/historico/historico_view.dart';
import 'package:rpg_app/presenter/personagens/personagens_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _itemSelecionado = 0;
  final List<Widget> _telas = [ArenaView(), PersonagensView(), HistoricoView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: _telas[_itemSelecionado],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _itemSelecionado,
        onTap: (index) {
          setState(() {
            _itemSelecionado = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.shield), label: 'Arena'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Personagens',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Histórico',
          ),
        ],
      ),
    );
  }
}
