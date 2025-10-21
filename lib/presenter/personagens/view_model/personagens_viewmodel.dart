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
  static const int _pontosTotais = 30;
  int _vidaBase = 0;
  int _escudoBase = 0;
  int _velocidadeBase = 0;

  Raca? get racaSelecionada => _racaSelecionada;
  Arquetipo? get arquetipoSelecionado => _arquetipoSelecionado;
  String get imagemPersonagem => _imagemPersonagem;
  int get vidaBase => _vidaBase;
  int get escudoBase => _escudoBase;
  int get velocidadeBase => _velocidadeBase;
  int get pontosTotais => _pontosTotais;
  int get pontosRestantes =>
      _pontosTotais - (_vidaBase + _escudoBase + _velocidadeBase);
  int get bonusVidaRaca => _racaSelecionada?.bonusVida ?? 0;
  int get bonusVidaArquetipo => _arquetipoSelecionado?.bonusVida ?? 0;
  int get bonusEscudoRaca => _racaSelecionada?.bonusEscudo ?? 0;
  int get bonusEscudoArquetipo => _arquetipoSelecionado?.bonusEscudo ?? 0;
  int get bonusVelocidadeRaca => _racaSelecionada?.bonusAtaque ?? 0;
  int get bonusVelocidadeArquetipo => _arquetipoSelecionado?.bonusAtaque ?? 0;
  int get vidaComBonus =>
      _vidaBase + bonusVidaRaca + bonusVidaArquetipo;
  int get escudoComBonus =>
      _escudoBase + bonusEscudoRaca + bonusEscudoArquetipo;
  int get velocidadeComBonus =>
      _velocidadeBase + bonusVelocidadeRaca + bonusVelocidadeArquetipo;
  bool get pontosDistribuidos => pontosRestantes == 0;

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

  void resetAtributos() {
    _vidaBase = 0;
    _escudoBase = 0;
    _velocidadeBase = 0;
    notifyListeners();
  }

  void ajustarVida(int delta) {
    _ajustarAtributo(
      delta: delta,
      obterAtual: () => _vidaBase,
      aplicar: (valor) => _vidaBase = valor,
    );
  }

  void ajustarEscudo(int delta) {
    _ajustarAtributo(
      delta: delta,
      obterAtual: () => _escudoBase,
      aplicar: (valor) => _escudoBase = valor,
    );
  }

  void ajustarVelocidade(int delta) {
    _ajustarAtributo(
      delta: delta,
      obterAtual: () => _velocidadeBase,
      aplicar: (valor) => _velocidadeBase = valor,
    );
  }

  void _ajustarAtributo({
    required int delta,
    required int Function() obterAtual,
    required void Function(int) aplicar,
  }) {
    final valorAtual = obterAtual();
    final novoValor = valorAtual + delta;
    if (novoValor < 0 || novoValor > _pontosTotais) {
      return;
    }

    final somaAtual = _vidaBase + _escudoBase + _velocidadeBase;
    final somaComNovo = somaAtual - valorAtual + novoValor;
    if (somaComNovo > _pontosTotais) {
      return;
    }

    aplicar(novoValor);
    notifyListeners();
  }
}
