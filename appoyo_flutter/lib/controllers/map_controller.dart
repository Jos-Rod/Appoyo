import 'package:get/get.dart';
import 'package:latlong/latlong.dart';

class MapInputController extends GetxController {
  LatLng position;

  void positionChanged(value){
    this.position = value;
    update();
  }
}