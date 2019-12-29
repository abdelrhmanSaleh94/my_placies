import 'package:flutter/material.dart';
import '../widget/input_image.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../provider/great_places.dart';
import '../widget/location_input.dart';
import '../model/place.dart';

class AddPlace extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceState createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final _titleController = TextEditingController();
  File _imagePicker;
  PlaceLocation _pickedLocation;
  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _selectImage(File imagepicker) {
    _imagePicker = imagepicker;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _imagePicker == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPleces(_titleController.text, _imagePicker, _pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add a new place'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(labelText: 'title'),
                        controller: _titleController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputImage(_selectImage),
                      SizedBox(
                        height: 10,
                      ),
                      LocationInput(_selectPlace),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: RaisedButton.icon(
                icon: Icon(Icons.add),
                label: Text('Add new Place'),
                onPressed: _savePlace,
                elevation: 5,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: Theme.of(context).accentColor,
              ),
            )
          ],
        ));
  }
}
