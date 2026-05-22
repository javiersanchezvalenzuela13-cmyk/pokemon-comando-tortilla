import 'package:flutter/material.dart';
import '../models/pokemon.dart';                  // Creado por Persona 1
import '../services/pokemon_service.dart';        // Creado por Persona 3
import '../widgets/search_pokemon_form.dart';     // Creado por Persona 5
import '../widgets/pokemon_card.dart';            // Creado por Persona 5

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 1. Inicialización de variables y servicios necesarios
  final PokemonService _service = PokemonService();
  final TextEditingController _controller = TextEditingController();

  Pokemon? _pokemon;
  bool     _isLoading = false;
  String?  _errorMessage;

  // 2. Función lógica para realizar la búsqueda
  Future<void> _buscar() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _pokemon = null;
    });

    try {
      // Llama al servicio de la Persona 3 usando el texto del controlador
      final resultado = await _service.searchPokemon(_controller.text);

      setState(() {
        _pokemon = resultado;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "No se encontró el Pokémon o hubo un error.";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex App'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Formulario de la Persona 5 (le inyectas tus estados y función)
              SearchPokemonForm(
                controller: _controller,
                onBuscar: _buscar,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 20),

              // Renderizado condicional según el estado de la pantalla
              if (_isLoading)
                const CircularProgressIndicator(),

              if (_errorMessage != null)
                Text(_errorMessage!, style: const TextStyle(color: Colors.red)),

              // Si hay un pokemon, mostramos su tarjeta (Persona 5)
              if (_pokemon != null)
                PokemonCard(pokemon: _pokemon!),
            ],
          ),
        ),
      ),
    );
  }
}