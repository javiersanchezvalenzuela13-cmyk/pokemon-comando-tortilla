import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pokemon.dart';

class PokemonService {

  static const String _url =
      'https://graphqlpokemon.favware.tech/v8';

  Future<Pokemon> searchPokemon(String name) async {

    const String query = '''
      query getFuzzyPokemon(\$pokemon: String!) {
        getFuzzyPokemon(pokemon: \$pokemon, take: 1) {
          species
          num
          color
          sprite
        }
      }
    ''';

    final response = await http.post(
      Uri.parse(_url),

      headers: {
        'Content-Type': 'application/json',
      },

      body: jsonEncode({
        'query': query,
        'variables': {
          'pokemon': name,
        },
      }),
    );

    // ERROR HTTP
    if (response.statusCode != 200) {
      throw Exception(
        'Error al conectar con la API'
      );
    }

    final Map<String, dynamic> data =
        jsonDecode(response.body);

    // ERROR GRAPHQL
    if (data.containsKey('errors')) {
      throw Exception(
        'La API devolvió un error'
      );
    }

    final List<dynamic> pokemonList =
        data['data']['getFuzzyPokemon'];

    // LISTA VACÍA
    if (pokemonList.isEmpty) {
      throw Exception(
        'No se encontró ningún Pokémon'
      );
    }

    // PRIMER POKEMON
    return Pokemon.fromJson(
      pokemonList.first,
    );
  }
}