import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; 
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapScreen extends StatefulWidget {
  final dynamic location; 

  const MapScreen({super.key, required this.location});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _locationCoordinates;

  @override
  void initState() {
    super.initState();
    if (widget.location is List<double>) {
      setState(() {
        _locationCoordinates = LatLng(widget.location[0], widget.location[1]);
      });
    } else {
      _getCoordinatesFromLocation(widget.location);
    }
  }

  Future<void> _getCoordinatesFromLocation(String location) async {
    final url = Uri.parse(
 'https://nominatim.openstreetmap.org/search?q=$location&format=json&limit=1');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.isNotEmpty) {
          final latitude = double.parse(data[0]['lat']);
          final longitude = double.parse(data[0]['lon']);
          setState(() {
            _locationCoordinates = LatLng(latitude, longitude);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location not found')),
          );
        }
      } else {
        throw Exception('Failed to load location');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Screen'),
      ),
      body: _locationCoordinates == null
          ?  Center(child:  Image.asset('assets/images/location-not-found.gif', scale: 0.4,),) 
          : FlutterMap(
              options: MapOptions(
                initialCenter: _locationCoordinates ?? LatLng(0, 0), 
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _locationCoordinates!,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
