import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/place.dart';
import 'package:flutter_application_1/search_screen.dart';
import 'package:flutter_application_1/models/storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({Key? key}) : super(key: key);

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  late GoogleMapController mapController;
  final CameraPosition _cameraInitPos = const CameraPosition(
    target: LatLng(50.775555, 6.083611),
    zoom: 11.0,
  );

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Set<Marker>> _generateMarkers() async {
    Storage storage = Storage();
    List<Place> places = await storage.getAllUnvisitedPlaces();

    Set<Marker> markers = {};
    for (Place p in places) {
      Marker m = Marker(
          markerId: MarkerId(p.placeId),
          position: p.latLng,
          infoWindow: InfoWindow(title: p.description));
      markers.add(m);
    }
    return markers;
  }

  /*
  void _centerCameraOnMyLocation() async {
    if (await Geolocator.isLocationServiceEnabled() == false) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enable location services')));
      return;
    }
    final myLocation = await Geolocator.getCurrentPosition();
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(myLocation.latitude, myLocation.longitude),
            zoom: await mapController.getZoomLevel(),
            bearing: 0),
      ),
    );
  }
  */

  @override
  void initState() {
    super.initState();
    Permission.locationWhenInUse.request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Overview Map')),
      body: Stack(
        children: [
          FutureBuilder(
            future: _generateMarkers(),
            builder: (context, AsyncSnapshot<Set<Marker>> snapshot) {
              if (snapshot.hasData) {
                // Markers were generated, display map
                return GoogleMap(
                  onMapCreated: _onMapCreated,
                  compassEnabled: true,
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  initialCameraPosition: _cameraInitPos,
                  markers: snapshot.data!,
                  mapToolbarEnabled: false,
                );
              }
              // Markers being loaded, display loading icon
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
      // Button to center the camera on the current location
      // A custom button is needed because the default one that comes with the Google map package
      // is hidden behind the searchbar and cannot be relocated.
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SearchScreen(),
          ),
          // Reload page when coming back to it
        ).then((_) => setState(() {})),
        child: const Icon(Icons.search),
      ),
    );
  }
}
