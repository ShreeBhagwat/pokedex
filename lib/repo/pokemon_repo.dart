import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/data/modals/pokemon.dart';
import 'package:pokedex/data/networking/dio_client.dart';
import 'package:pokedex/utils/constant.dart';

class PokemonRepo {
  Future<List<Pokemon>> getPokemonList() async {
    final dio = DioClient();
    try {
      final response = await dio.get(POKEMON_API_URL);
      if (response.statusCode == 200) {
        final List<Pokemon> pokemonList = [];
        final decodedData = jsonDecode(response.data);

        decodedData.forEach((element) {
          pokemonList.add(Pokemon.fromJson(element));
        });
        return pokemonList;
      } else {
        return Future.error(
            'Failed to load pokemon list ${response.statusCode} ');
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}

final pokemonRepoProvider = Provider((ref) => PokemonRepo());
