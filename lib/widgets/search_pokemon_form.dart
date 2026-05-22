import 'package:flutter/material.dart';

class SearchPokemonForm extends StatelessWidget {

  final TextEditingController controller;
  final VoidCallback onBuscar;
  final bool isLoading;

  const SearchPokemonForm({
    super.key,
    required this.controller,
    required this.onBuscar,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16),

      child: Column(
        children: [

          TextField(
            controller: controller,

            decoration: const InputDecoration(
              labelText: 'Nombre del Pokémon',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,

            child: ElevatedButton(

              onPressed: isLoading
                  ? null
                  : onBuscar,

              child: const Text(
                'Buscar Pokémon',
              ),
            ),
          ),
        ],
      ),
    );
  }
}