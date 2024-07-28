import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/data/modals/pokemon.dart';
import 'package:pokedex/repo/hive_repo.dart';
import 'package:pokedex/utils/helpers.dart';

import 'widgets/pokemon_detail_row_widget.dart';
import 'widgets/rotating_image_widget.dart';

class PokemonDetailScreen extends StatelessWidget {
  const PokemonDetailScreen({super.key, required this.pokemon});
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Helpers.getPokemonCardColour(
          pokemonType: pokemon.typeofpokemon!.first),
      appBar: AppBar(
        title: Text(
          pokemon.name!,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Helpers.getPokemonCardColour(
            pokemonType: pokemon.typeofpokemon!.first),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Consumer(
              builder: (context, ref, child) {
                return IconButton(
                  onPressed: () async {
                    await ref
                        .read(hiveProvider)
                        .addPokemonToList(pokemon)
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Pokemon added to favourites')),
                      );
                    }).catchError((e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$e')),
                      );
                    });
                  },
                  icon: const Icon(
                    Icons.favorite,
                    size: 30,
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned(
              left: (width / 2) - 125, top: 50, child: const RotatingImage()),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              height: MediaQuery.of(context).size.height * 0.55,
              width: width,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 10, bottom: 10),
                    child: Text(
                      pokemon.xdescription!,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  PokemonDetailRowWidget(
                    title: 'Name',
                    value: pokemon.name!,
                  ),
                  PokemonDetailRowWidget(
                    title: 'type',
                    value: pokemon.typeofpokemon!.join(', '),
                  ),
                  PokemonDetailRowWidget(
                    title: 'Health',
                    value: pokemon.hp.toString(),
                  ),
                  PokemonDetailRowWidget(
                    title: 'Speed',
                    value: pokemon.speed!.toString(),
                  ),
                  PokemonDetailRowWidget(
                    title: 'Attack',
                    value: pokemon.attack.toString(),
                  ),
                  PokemonDetailRowWidget(
                    title: 'Defense',
                    value: pokemon.defense!.toString(),
                  ),
                  PokemonDetailRowWidget(
                    title: 'Special Attack',
                    value: pokemon.special_attack.toString(),
                  ),
                  PokemonDetailRowWidget(
                    title: 'Weakness',
                    value: pokemon.weaknesses!.join(', '),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: (width / 2) - 125,
            child: Hero(
              tag: pokemon.id!,
              child: CachedNetworkImage(
                imageUrl: pokemon.imageurl!,
                width: 250,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
