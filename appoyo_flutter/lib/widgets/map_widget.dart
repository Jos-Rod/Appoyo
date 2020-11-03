import 'package:appoyo_flutter/controllers/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';

import 'package:geolocator/geolocator.dart';

class MapWidget extends StatefulWidget {

  MapInputController mapInputController;

  MapWidget({this.mapInputController}):super();
  
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {

  LatLng pos = LatLng(0,0);
  MapController controller = MapController();

  @override
  Widget build(BuildContext context) {
    _getCurrentLocation(widget.mapInputController);

    return new FlutterMap(
      mapController: controller,
      options: new MapOptions(
        center: pos,
        zoom: 13.0,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c']
        ),
        new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 50.0,
              height: 50.0,
              point: pos,
              builder: (ctx) =>
              new Container(
                child: Icon(Icons.location_on, size: 50),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _getCurrentLocation(MapInputController mapInputController) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    pos = LatLng(position.latitude, position.longitude);
    setState(() {
      controller.move(pos, 13);
      mapInputController.positionChanged(pos);
    });
  }
}