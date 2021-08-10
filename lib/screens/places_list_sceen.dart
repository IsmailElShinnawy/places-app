import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/great_places.dart';
import './place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (child, dataSnapshot) => dataSnapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                  child: Text(
                    'You did not add any places yet',
                  ),
                ),
                builder: (ctx, greatPlaces, child) =>
                    greatPlaces.items.length == 0
                        ? child
                        : ListView.builder(
                            itemBuilder: (ctx, idx) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(greatPlaces.items[idx].image),
                              ),
                              title: Text(greatPlaces.items[idx].title),
                              subtitle:
                                  Text(greatPlaces.items[idx].location.address),
                              onTap: () {
                                // go to details page
                                Navigator.of(context).pushNamed(
                                    PlaceDetailScreen.routeName,
                                    arguments: greatPlaces.items[idx].id);
                              },
                            ),
                            itemCount: greatPlaces.items.length,
                          ),
              ),
      ),
    );
  }
}
