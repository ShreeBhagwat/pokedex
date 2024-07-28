import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/data/modals/pokemon.dart';
import 'package:pokedex/repo/hive_repo.dart';
import 'package:pokedex/ui/pokemon_detail_screen.dart';

class FavPokemonScreen extends ConsumerStatefulWidget {
  const FavPokemonScreen({super.key});

  @override
  ConsumerState<FavPokemonScreen> createState() => _FavPokemonScreenState();
}

class _FavPokemonScreenState extends ConsumerState<FavPokemonScreen> {
  final List<Pokemon> pokemonList = [];
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      ref.read(hiveProvider).getFavPokemonList().then((value) {
        setState(() {
          pokemonList.addAll(value);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Pokemon'),
      ),
      body: pokemonList.isEmpty
          ? const Center(child: Text('No Fav Pokemon'))
          : ListView.builder(
              itemCount: pokemonList.length,
              itemBuilder: (context, index) {
                final Pokemon pokemon = pokemonList[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => PokemonDetailScreen(pokemon: pokemon),
                      ),
                    );
                  },
                  title: Text(pokemon.name!),
                  subtitle: Text(pokemon.typeofpokemon!.first),
                  leading: Image.network(pokemon.imageurl!),
                  trailing: IconButton(
                    onPressed: () async {
                      await ref
                          .read(hiveProvider)
                          .removePokemonFromList(pokemon.id!)
                          .then((value) {
                        setState(() {
                          pokemonList.remove(pokemon);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Pokemon removed from favourites')),
                        );
                      }).catchError((e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Failed to remove Pokemon from favourites')),
                        );
                      });
                    },
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            ),
    );
  }
}
