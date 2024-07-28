import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/data/modals/pokemon.dart';
import 'package:pokedex/repo/pokemon_repo.dart';

final pokemonFutureProvider = FutureProvider<List<Pokemon>>((ref) async {
  final List<Pokemon> pokemonList =
      await ref.read(pokemonRepoProvider).getPokemonList();
  return pokemonList;
});
