import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectedLocation;

  const LocationInput(this.onSelectedLocation);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  Future<void> _getCurrentlocation() async {
    try {
      final local = await Location().getLocation();
      final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
          latitude: local.latitude, longitude: local.longitude);
      widget.onSelectedLocation(local.latitude, local.longitude);
      setState(() {
        _previewImageUrl = staticMapImageUrl;
      });
    } catch (error) {}
  }

  Future<void> _openMap() async {
    final local = await Location().getLocation();
    LocationHelper.openMap(local.latitude, local.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.location_on,
              ),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentlocation,
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.map,
              ),
              label: Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _openMap,
            ),
          ],
        ),
      ],
    );
  }
}
