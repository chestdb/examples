import 'package:animal_names/animal_names.dart';
import 'package:flutter/material.dart';
import 'package:chest_flutter/chest_flutter.dart';

const allAnimals = all_animals;
final favorites = Chest<Set<String>>('favoriteAnimals', ifNew: () => {});

void main() async {
  await initializeChest();
  tape.register({
    ...tapers.forDartCore,
    0: taper.forSet<String>(),
  });
  await favorites.open();
  runApp(FavoriteAnimalsApp());
}

class FavoriteAnimalsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorite Animals',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: Scaffold(
        appBar: AppBar(title: Text('Favorite Animals')),
        body: ListView.builder(
          itemCount: allAnimals.length,
          itemBuilder: (context, index) {
            final animal = allAnimals[index];
            return ListTile(
              title: Text(animal),
              trailing: ReferenceBuilder(
                reference: favorites[animal],
                builder: (_) {
                  return IconButton(
                    icon: Icon(
                      favorites.contains(animal)
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    onPressed: () => favorites.toggle(animal),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
