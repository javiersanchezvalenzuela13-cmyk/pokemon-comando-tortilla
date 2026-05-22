class Pokemon {

  final String species;
  final int num;
  final String color;
  final String sprite;

  const Pokemon({
    required this.species,
    required this.num,
    required this.color,
    required this.sprite,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      species: json['species'] as String? ?? 'Desconocido',
      num:     json['num']     as int?    ?? 0,
      color:   json['color']   as String? ?? 'Desconocido',
      sprite:  json['sprite']  as String? ?? '',
    );
  }

}