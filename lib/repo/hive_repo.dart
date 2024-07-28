import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:pokedex/data/modals/pokemon.dart';

class HiveRepo {
  final String _pokemonBox = 'pokemonBox';
  void registerHiveAdapter() {
    Hive.registerAdapter(PokemonAdapter());
  }

  Future addPokemonToList(Pokemon pokemon) async {
    try {
      final pokemonBox = await Hive.openBox<Pokemon>(_pokemonBox);
      if (pokemonBox.isOpen) {
        log('Box is open');
        if (pokemonBox.containsKey(pokemon.id)) {
          throw Exception('Pokemon already added to favourites');
        }
        pokemonBox.put(pokemon.id, pokemon);
      } else {
        return Future.error('Failed to open box');
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<Pokemon>> getFavPokemonList() async {
    final pokemonBox = await Hive.openBox<Pokemon>(_pokemonBox);
    return pokemonBox.values.toList();
  }

  Future removePokemonFromList(String pokemonid) async {
    final pokemonBox = await Hive.openBox<Pokemon>(_pokemonBox);
    pokemonBox.delete(pokemonid);
  }
}

final hiveProvider = Provider((ref) => HiveRepo());
