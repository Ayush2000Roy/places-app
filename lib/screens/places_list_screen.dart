import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/add_place_screen.dart';
import '../screens/places_detail_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                    child: const Text('No places yet, start adding some!')),
                builder: (context, gPData, child) => gPData.items.length <= 0
                    ? child
                    : ListView.builder(
                        itemCount: gPData.items.length,
                        itemBuilder: (context, index) => Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(
                                gPData.items[index].image,
                              ),
                            ),
                            title: Text(gPData.items[index].title),
                            subtitle:
                                Text(gPData.items[index].location.address),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                PlaceDetailScreen.routeName,
                                arguments: gPData.items[index].id,
                              );
                            },
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}
