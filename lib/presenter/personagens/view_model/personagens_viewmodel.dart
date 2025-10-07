import 'package:flutter/material.dart';
import 'package:rpg_app/data/personagem/arquetipo_repository.dart';
import 'package:rpg_app/data/personagem/personagem_repository.dart';
import 'package:rpg_app/data/personagem/raca_repository.dart';
import 'package:rpg_app/domain/entities/personagem.dart';
import 'package:rpg_app/domain/entities/arquetipo.dart';
import 'package:rpg_app/domain/entities/raca.dart';
import 'package:rpg_app/domain/usecases/get_personagem_image.dart';

class PersonagensViewmodel extends ChangeNotifier {
  final PersonagemRepository _repository;
  final ArquetipoRepository _arquetipoRepository;
  final RacaRepository _racaRepository;

  final List<Personagem> _personagens = [];
  Raca? _racaSelecionada;
  Arquetipo? _arquetipoSelecionado;
  String _imagemPersonagem = GetPersonagemImageUsecase.execute(null, null);

  Raca? get racaSelecionada => _racaSelecionada;
  Arquetipo? get arquetipoSelecionado => _arquetipoSelecionado;
  String get imagemPersonagem => _imagemPersonagem;

  PersonagensViewmodel(
    this._repository,
    this._arquetipoRepository,
    this._racaRepository,
  );

  List<Personagem> get personagens => _personagens;

  List<Arquetipo> get arquetiposDisponiveis => _arquetipoRepository.list();
  List<Raca> get racasDisponiveis => _racaRepository.list();

  void carregarPersonagens() {
    _personagens
      ..clear()
      ..addAll(_repository.list());
    notifyListeners();
  }

  void create(Personagem personagem) {
    _repository.adicionar(personagem);
    carregarPersonagens();
  }

  void setRaca(Raca raca) {
    _racaSelecionada = raca;
    _atualizarImagem();
  }

  void setArquetipo(Arquetipo arquetipo) {
    _arquetipoSelecionado = arquetipo;
    _atualizarImagem();
  }

  void _atualizarImagem() {
    _imagemPersonagem = GetPersonagemImageUsecase.execute(
      _racaSelecionada,
      _arquetipoSelecionado,
    );
    notifyListeners();
  }
}
