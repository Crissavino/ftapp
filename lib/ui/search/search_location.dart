import 'package:app/models/user_location.dart';
import 'package:app/repositories/location_repository.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:app/services/place_service.dart';
import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/bloc/complete_profile/complete_profile_bloc.dart';

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
          ? BlocBuilder<CompleteProfileBloc, CompleteProfileState>(
              builder: (BuildContext context, state) {
              if (state is ProfileCompleteLoadingUserLocationState) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [circularLoading],
                  ),
                );
              }
              return Container(
                padding: EdgeInsets.all(16.0),
                child: ListTile(
                  leading: Icon(Icons.my_location),
                  title: Text('Mi ubicacion'),
                  onTap: () async {
                    BlocProvider.of<CompleteProfileBloc>(context)
                        .add(ProfileCompleteLoadingUserLocationEvent());
                    final myLatLong =
                        await LocationRepository().determinePosition();
                    final location = await PlaceApiProvider(sessionToken)
                        .fetchMyLocation(
                            myLatLong.latitude, myLatLong.longitude);
                    final UserLocation locationDetails =
                        await PlaceApiProvider(sessionToken)
                            .getPlaceDetailFromId(location.placeId);
                    locationDetails.lat = location.details.lat;
                    locationDetails.lng = location.details.lng;
                    final Suggestion myLocationSuggestion = Suggestion(
                        location.placeId,
                        location.description,
                        locationDetails,
                    );

                    close(context, myLocationSuggestion);
                  },
                ),
              );
            })
          : snapshot.hasData
              ? BlocBuilder<CompleteProfileBloc, CompleteProfileState>(
                  builder: (BuildContext context, state) {
                    if (state is ProfileCompleteLoadingUserLocationState) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [circularLoading],
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          // we will display the data returned from our future here
                          title: Text(snapshot.data[index].description),
                          onTap: () async {
                            print(snapshot.data[index].details.lng);
                            final UserLocation locationDetails =
                                await PlaceApiProvider(sessionToken)
                                    .getPlaceDetailFromId(
                                        snapshot.data[index].placeId);
                            locationDetails.lng = snapshot.data[index].details.lng;
                            locationDetails.lat = snapshot.data[index].details.lat;
                            final Suggestion myLocationSuggestion = Suggestion(
                                snapshot.data[index].placeId,
                                snapshot.data[index].description,
                                locationDetails);

                            close(context, myLocationSuggestion);
                          },
                        );
                      },
                    );
                  },
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [circularLoading],
                  ),
                ),
    );
  }
}
