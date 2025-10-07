import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpg_app/data/personagem/arquetipo_repository.dart';
import 'package:rpg_app/data/personagem/personagem_repository.dart';
import 'package:rpg_app/data/personagem/raca_repository.dart';
import 'package:rpg_app/presenter/personagens/view_model/personagens_viewmodel.dart';
import 'package:rpg_app/presenter/rpg_app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<PersonagemRepository>(create: (_) => PersonagemRepository()),
        Provider<RacaRepository>(create: (_) => RacaRepository()),
        Provider<ArquetipoRepository>(create: (_) => ArquetipoRepository()),
        ChangeNotifierProvider<PersonagensViewmodel>(
          create:
              (context) => PersonagensViewmodel(
                context.read<PersonagemRepository>(),
                context.read<ArquetipoRepository>(),
                context.read<RacaRepository>(),
              ),
        ),
      ],
      child: const RpgApp(),
    ),
  );
}
