import 'package:flutter/material.dart';
import 'package:rpg_app/presenter/personagens/views/personagem_create_view.dart';
import 'package:rpg_app/presenter/personagens/views/personagens_list_view.dart';

class PersonagensView extends StatelessWidget {
  const PersonagensView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const PersonagensListView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PersonagemCreateView(),
            ),
          );
        },
      ),
    );
  }
}
