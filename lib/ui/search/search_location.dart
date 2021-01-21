import 'package:app/models/user_location.dart';
import 'package:app/repositories/location_repository.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:app/services/place_service.dart';
import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SearchLocation extends SearchDelegate<Suggestion> {
  final LocationRepository _locationRepository = LocationRepository();
  final sessionToken = Uuid().v4();

  @override
  final String searchFieldLabel;

  SearchLocation() : this.searchFieldLabel = 'Buscar...';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => this.query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => this.close(context, null),
    );
    return Text('buildLeading');
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      // We will put the api call here
      future: PlaceApiProvider(sessionToken).fetchSuggestions(query),
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(16.0),
              child: ListTile(
                leading: Icon(Icons.my_location),
                title: Text('Mi ubicacion'),
                onTap: () async {
                  final myLatLong = await LocationRepository().determinePosition();
                  final location = await PlaceApiProvider(sessionToken).fetchMyLocation(
                      myLatLong.latitude,
                      myLatLong.longitude
                  );
                  final UserLocation locationDetails = await PlaceApiProvider(sessionToken).getPlaceDetailFromId(location.placeId);
                  final Suggestion myLocationSuggestion = Suggestion(location.placeId, '${locationDetails.city}, ${locationDetails.province}, ${locationDetails.country}', locationDetails);

                  close(context, myLocationSuggestion);

                  // print(myLocation.toString());
                },
              ),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    print(snapshot.data[0]);
                    return ListTile(
                      // we will display the data returned from our future here
                      title: Text(snapshot.data[index].description),
                      onTap: () async {
                        final UserLocation locationDetails = await PlaceApiProvider(sessionToken).getPlaceDetailFromId(snapshot.data[index].placeId);
                        final Suggestion myLocationSuggestion = Suggestion(snapshot.data[index].placeId, '${locationDetails.city}, ${locationDetails.province}, ${locationDetails.country}', locationDetails);

                        close(context, myLocationSuggestion);
                      },
                    );
                  },
                )
              : Container(
                  padding: EdgeInsets.all(40.0),
                  alignment: Alignment.topCenter,
                  child: circularLoading,
                ),
    );
  }
}
