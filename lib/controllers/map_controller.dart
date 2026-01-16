import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class MapController extends GetxController {
  GoogleMapController? mapController;
  
  final markers = RxSet<Marker>({});
  final circles = RxSet<Circle>({});
  final isLoading = true.obs;
  final currentZoom = 15.0.obs;
  final currentBearing = 0.0.obs;
  final currentMapType = MapType.normal.obs;
  
  Rx<Position?> currentPosition = Rx<Position?>(null);
  LatLng? previousPosition;
  
  StreamSubscription<Position>? positionStreamSubscription;
  
  static const LatLng defaultLocation = LatLng(-6.423451, 107.012345);

  @override
  void onInit() {
    super.onInit();
    initializeMap();
  }

  @override
  void onClose() {
    mapController?.dispose();
    positionStreamSubscription?.cancel();
    super.onClose();
  }

  Future<void> initializeMap() async {
    await checkPermissions();
    await getCurrentLocation();
    await startLocationUpdates();
  }

  Future<void> checkPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error', 'Aktifkan layanan lokasi');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Error', 'Izin lokasi ditolak');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Error', 'Izin lokasi ditolak permanen');
      return;
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      currentPosition.value = position;
      currentBearing.value = position.heading;
      isLoading.value = false;
      updateMarker(position);

      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: currentZoom.value,
            bearing: currentBearing.value,
          ),
        ),
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> startLocationUpdates() async {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5,
    );

    positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) {
      currentPosition.value = position;
      currentBearing.value = position.heading;
      updateMarker(position);

      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: currentZoom.value,
            bearing: currentBearing.value,
          ),
        ),
      );
    });
  }

  void updateMarker(Position position) {
    final newPosition = LatLng(position.latitude, position.longitude);
    
    if (previousPosition != null) {
      animateMarker(previousPosition!, newPosition, position.heading, position.accuracy);
    } else {
      markers.assignAll({
        Marker(
          markerId: const MarkerId('current_location'),
          position: newPosition,
          rotation: position.heading,
          anchor: const Offset(0.5, 0.5),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      });
      circles.assignAll({
        Circle(
          circleId: const CircleId('accuracy_circle'),
          center: newPosition,
          radius: position.accuracy,
          fillColor: const Color(0xFF2D7A4F).withOpacity(0.1),
          strokeColor: const Color(0xFF2D7A4F).withOpacity(0.3),
          strokeWidth: 1,
        ),
      });
    }
    
    previousPosition = newPosition;
  }

  void animateMarker(LatLng from, LatLng to, double rotation, double accuracy) {
    const duration = Duration(milliseconds: 500);
    const steps = 30;
    final stepDuration = duration.inMilliseconds ~/ steps;
    
    int currentStep = 0;
    
    Timer.periodic(Duration(milliseconds: stepDuration), (timer) {
      if (currentStep >= steps) {
        timer.cancel();
        return;
      }
      
      currentStep++;
      final t = currentStep / steps;
      
      final lat = from.latitude + (to.latitude - from.latitude) * t;
      final lng = from.longitude + (to.longitude - from.longitude) * t;
      final currentPos = LatLng(lat, lng);
      
      markers.assignAll({
        Marker(
          markerId: const MarkerId('current_location'),
          position: currentPos,
          rotation: rotation,
          anchor: const Offset(0.5, 0.5),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      });
      circles.assignAll({
        Circle(
          circleId: const CircleId('accuracy_circle'),
          center: currentPos,
          radius: accuracy,
          fillColor: const Color(0xFF2D7A4F).withOpacity(0.1),
          strokeColor: const Color(0xFF2D7A4F).withOpacity(0.3),
          strokeWidth: 1,
        ),
      });
    });
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (currentPosition.value != null) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(currentPosition.value!.latitude, currentPosition.value!.longitude),
            zoom: currentZoom.value,
            bearing: currentBearing.value,
          ),
        ),
      );
    }
  }

  void goToCurrentLocation() {
    if (currentPosition.value != null && mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(currentPosition.value!.latitude, currentPosition.value!.longitude),
            zoom: currentZoom.value,
            bearing: currentBearing.value,
            tilt: 45.0,
          ),
        ),
      );
    }
  }

  void toggleMapType() {
    currentMapType.value = currentMapType.value == MapType.normal 
        ? MapType.satellite 
        : MapType.normal;
  }

  void onCameraMove(CameraPosition position) {
    currentZoom.value = position.zoom;
    currentBearing.value = position.bearing;
  }
}
