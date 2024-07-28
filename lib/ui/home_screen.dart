import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/data/modals/pokemon.dart';
import 'package:pokedex/providers/pokemon_future_provider.dart';
import 'package:pokedex/providers/theme_provider.dart';
import 'package:pokedex/ui/fave_pokemon_screen.dart';
import 'package:pokedex/ui/pokemon_detail_screen.dart';
import 'package:pokedex/utils/helpers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Pokemon>> pokemonList = ref.watch(pokemonFutureProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const FavPokemonScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.lightbulb),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
        ],
      ),
      body: pokemonList.when(data: (data) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                final Pokemon pokemon = data[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => PokemonDetailScreen(pokemon: pokemon),
                      ),
                    );
                  },
                  child: Card(
                      color: Helpers.getPokemonCardColour(
                          pokemonType: pokemon.typeofpokemon!.first),
                      child: Stack(
                        children: [
                          Positioned(
                            right: -10,
                            bottom: -10,
                            child: Image.asset(
                              'images/pokeball.png',
                              height: 120,
                              width: 120,
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Text(
                              pokemon.name!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          Positioned(
                            top: 40,
                            left: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(pokemon.typeofpokemon!.first,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16)),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -10,
                            right: 0,
                            child: Hero(
                              tag: pokemon.id!,
                              child: CachedNetworkImage(
                                height: 130,
                                width: 130,
                                fit: BoxFit.cover,
                                imageUrl: pokemon.imageurl!,
                                placeholder: (context, url) {
                                  return const CircularProgressIndicator();
                                },
                                errorWidget: (context, url, error) {
                                  return const Icon(Icons.error);
                                },
                              ),
                            ),
                          ),
                        ],
                      )),
                );
              }),
        );
      }, error: (error, stc) {
        return Center(
          child: Text(error.toString()),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
