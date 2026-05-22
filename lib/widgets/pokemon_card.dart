import 'package:flutter/material.dart';

import '../models/pokemon.dart';

class PokemonCard extends StatelessWidget {

  final Pokemon pokemon;

  const PokemonCard({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      margin: const EdgeInsets.all(16),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [

            Image.network(

              pokemon.sprite,

              height: 200,

              loadingBuilder:
                  (
                    context,
                    child,
                    loadingProgress,
                  ) {

                if (loadingProgress == null) {
                  return child;
                }

                return const CircularProgressIndicator();
              },

              errorBuilder:
                  (
                    context,
                    error,
                    stackTrace,
                  ) {

                return const Icon(
                  Icons.error,
                  size: 100,
                );
              },
            ),

            const SizedBox(height: 16),

            Text(
              pokemon.species,

              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Número Pokédex: ${pokemon.num}',
            ),

            const SizedBox(height: 8),

            Text(
              'Color: ${pokemon.color}',
            ),
          ],
        ),
      ),
    );
  }
}