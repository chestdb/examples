import 'package:animal_names/animal_names.dart';
import 'package:flutter/material.dart';
import 'package:chest_flutter/chest_flutter.dart';

final favorites = Chest<Set<String>>('favorites', ifNew: () => {});

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
    return DefaultTabController(
      length: 2,
      child: MaterialApp(
        title: 'Favorite Animals',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Favorite Animals'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'All'),
                Tab(text: 'Favorites'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                itemCount: all_animals.length,
                itemBuilder: (context, index) =>
                    AnimalTile(animal: all_animals[index]),
              ),
              ReferenceBuilder(
                reference: favorites,
                builder: (_) {
                  return ListView(
                    children: [
                      for (final animal in favorites.value.toList()..sort())
                        AnimalTile(animal: animal),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimalTile extends StatelessWidget {
  const AnimalTile({Key key, @required this.animal}) : super(key: key);

  final String animal;

  @override
  Widget build(BuildContext context) {
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
  }
}
