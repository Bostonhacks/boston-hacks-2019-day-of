// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:typed_data';

// void main() => runApp(MaterialApp(
//       home: _MyHomePage(),
//       debugShowCheckedModeBanner: false,
//     ));

class ScanPage extends StatefulWidget {
  ScanPage();
  @override
  ScanPageState createState() => ScanPageState();
}

class ScanPageState extends State<ScanPage> {
  CameraLensDirection _direction = CameraLensDirection.back;
  bool _runDetection = false;
  bool _isDetecting = false;
  CameraController _camera;
  var _isCheckedIn = false;
  var _food1Status = false;
  var _food2Status = false;
  var _food3Status = false;
  var _food4Status = false;
  var userNotFoundError;
  var stackIndex = 0;
  var _scanResults;
  var index;
  var data;

  static final accountCredentials =
      new auth.ServiceAccountCredentials.fromJson(r'''
      {
        "private_key_id": "33337eade91bc936237b94fa50bfbf9bd203cfc5",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCTonCABXGxJ6cT\nLipG9a1OvpsfnOm6FrBVUlNKytkYsFOXYZI8pJQd9SqRQkJZ/8EOLM2feDg4XyUN\n0YasDGymde0wU+EI40iXXygNiAUAKKbt/NMBTqIwF07GlzBVZ4xXmCCp0FdosAgl\nuC8e3Dev92J2eWM6vw9j/2QQuGBYZzKRQ65MJ98hjckEJlxCcAaR4jtXW2/fMx+J\n7gaRdfVfJjyvRmxo2G2HlC7u7Putq6R0UwfIseseBrqZeRdDrroFDvf7zdXT4X3l\nAjibnglPLFaNZc06qD4ALbYAkaxHd7X4UOxBfyN3E0ZyfJdE0e9x4/QOFsLlE3wl\ntIZ39aKxAgMBAAECggEABDGpvvQ0RmY6qINsLfMPYo4m/+ZoNkrmQiEn/q5Yc1E8\newysZ+MTvwU2pTlNVMnT4MSenGt1M5aVFXxGcIsQio3ezLATJReg7focR8RPCGwT\nle12tCwe69peYXyD82b5yytr9WWRAQdL5iMlH4qgo0VQQVpaoFe+4PTEnTBwbJm4\nq+dZUKdBwh56rEHtBdOG05SCd9r8VdKJftJUonSzNUgb2FRyYFcG+i8ag4bFx59d\nMTKxdF3m88QaMvyIM88w206u4Tnyj30s9D08IjZRJvzXvylBIPf4k+d8nYipEwtn\nqBKhuISeycoStLJY0n9QIodAxltx92ziTK0+nkdLCwKBgQDKvjPmoqrmAkd3Ylxy\nawYno9G7vlpw+RzUbuxVzkQzLZpvx/19FvhL9YG33ZpZvRwvI8+/an1RdRCT5y59\n5/8k7Lm4bHWN8tIPUzmNyTDC4DktJdPGg5WkZ79f4JlwXdIqvYgjr2uKds3XcXjS\nAcrT1xI+cTcF651d2hV6K+3u5wKBgQC6amACECyu7mDauLaUp5sIQpBlGMnRcVuo\nWinPWubtjak4oISe1a3y4/G7GfibZc/t1xT1gfneEETgae01U9gXgTYaYLLeWQl4\niaUqRq+9OCr+TZA5TFZrliJzXDoaHWtlY1VKUNDJAI2EbHQu5fgqDuTH3E7KRhpC\nm0+X0OOmpwKBgQC5hJw3YgghmlpM6uuPI1GpeiTTt9ZIZBs2ZB3MUodjkUotGQJi\nsV8ZGpjNZ3DyxrIAjLNwA4CSxh0aScPoIB7/acJz+IMFFfmTXmNe04fT+ps3LdMA\nZq3Kl8itcfbVtHQ4+d+WT9GHDTlD+ChHeq5fdADUtIJV34jLNWDLv2DkZwKBgE6A\n46OayiZ07sbNSN57YtdsqMBaWwtfsJjKN5dCEcPyh1P4jUESfWmvQqpneoF+s7zW\nedYWAXLZ6ReUpDdz8qmbWXxsQodOeaWQWcTe9b06vShQ466tjitKk4F/UlyTDRoq\nZc2hEPvExtQAlED3ybV0hjYAehHGyeJI45DsgCI7AoGALrgdTo1NECIbg7TN5oDn\nEEWNWab5Q/J6uNVmsJO+fKqOm6G9Rbtl5S/OT2QR4r8C8kbn3FekgTnQGXCiX/mW\nJzumYc9WluK2cF4h1SzefQ+bjO34FxHTmuNLRxzAKjlbawMA4tNj1BXwffqUEjaD\nnCHu6JswxyWSLS4pXK104J0=\n-----END PRIVATE KEY-----\n",
        "client_email": "bostonhacks2019-day-of@appspot.gserviceaccount.com",
        "client_id": "115360133312863885551",
        "type": "service_account"
      }
      ''');

  static final scopes = [sheets.SheetsApi.SpreadsheetsScope];

  final authorizedClient =
      auth.clientViaServiceAccount(accountCredentials, scopes);

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<CameraDescription> getCamera(CameraLensDirection dir) async {
    return await availableCameras().then(
      (List<CameraDescription> cameras) => cameras.firstWhere(
        (CameraDescription camera) => camera.lensDirection == dir,
      ),
    );
  }

  Uint8List _concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  FirebaseVisionImageMetadata _buildMetaData(
    CameraImage image,
    ImageRotation rotation,
  ) {
    return FirebaseVisionImageMetadata(
      rawFormat: image.format.raw,
      size: Size(image.width.toDouble(), image.height.toDouble()),
      rotation: rotation,
      planeData: image.planes.map(
        (Plane plane) {
          return FirebaseVisionImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        },
      ).toList(),
    );
  }

  ImageRotation _rotationIntToImageRotation(int rotation) {
    switch (rotation) {
      case 0:
        return ImageRotation.rotation0;
      case 90:
        return ImageRotation.rotation90;
      case 180:
        return ImageRotation.rotation180;
      default:
        assert(rotation == 270);
        return ImageRotation.rotation270;
    }
  }

  _captureWidget(var size) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            width: double.infinity,
            height: 150.0,
            padding: EdgeInsets.all(40.0),
            child: Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      RaisedButton(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 24.0),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            side: BorderSide(color: Colors.blue)),
                        onPressed: () async {
                          final rawData = await auth
                              .clientViaServiceAccount(
                                  accountCredentials, scopes)
                              .then((onValue) {
                            return sheets.SheetsApi(onValue)
                                .spreadsheets
                                .values
                                .get(
                                    '1dD94ZpGxgyYovrNs11kOjv6cxj6XtUby7Zqz2TH-exw',
                                    'A2:J900');
                          });
                          setState(() {
                            data = rawData;
                          });
                          _runDetection = true;
                          stackIndex = 1;
                        },
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text("Scan".toUpperCase(),
                            style: TextStyle(fontSize: 14)),
                      ),
                    ])
              ],
            )));
  }

  void _initializeCamera() async {
    final CameraDescription description = await getCamera(_direction);

    _camera = CameraController(
      description,
      ResolutionPreset.high,
    );
    await _camera.initialize();

    setState(() {});

    _camera.startImageStream((CameraImage image) {
      if (!_runDetection || _isDetecting) return;

      _isDetecting = true;

      FirebaseVision.instance
          .barcodeDetector()
          .detectInImage(
            FirebaseVisionImage.fromBytes(
              _concatenatePlanes(image.planes),
              _buildMetaData(image,
                  _rotationIntToImageRotation(description.sensorOrientation)),
            ),
          )
          .then((onValue) async {
        setState(() {});
        if (onValue.isNotEmpty) {
          _runDetection = false;
          index =
              data.values.indexWhere((data) => data[0] == onValue[0].rawValue) +
                  2;
          if (index > -1) {
            setState(() {
              _scanResults = data.values[index - 2];
              _isCheckedIn = data.values[index - 2][5] == "1" ? true : false;
              _food1Status = data.values[index - 2][6] == "1" ? true : false;
              _food2Status = data.values[index - 2][7] == "1" ? true : false;
              _food3Status = data.values[index - 2][8] == "1" ? true : false;
              _food4Status = data.values[index - 2][9] == "1" ? true : false;
            });
          } else {
            userNotFoundError = "User Not Found";
          }
        }
      }).whenComplete(() {
        _isDetecting = false;
      });
    });
  }

  Widget _buildImage() {
    final size = MediaQuery.of(context).size;
    return Container(
      constraints: const BoxConstraints.expand(),
      child: _camera == null
          ? const Center(
              child: Text(
                'Initializing Camera...',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30.0,
                ),
              ),
            )
          : Stack(
              fit: StackFit.expand,
              children: <Widget>[
                CameraPreview(_camera),
                IndexedStack(
                  index: stackIndex,
                  children: <Widget>[
                    _captureWidget(size),
                    _scanResults == null
                        ? AlertDialog(
                            title: Text("User Not Found"),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text('Ah Fuck'),
                                onPressed: () {
                                  setState(() {
                                    _scanResults = null;
                                    stackIndex = 0;
                                  });
                                },
                              ),
                            ],
                          )
                        : AlertDialog(
                            title: Text("User Data"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: Text(_scanResults[1]),
                                  subtitle: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(_scanResults[2]),
                                      Text(
                                          "Dietary Restriction: ${_scanResults[3]}"),
                                    ],
                                  ),
                                ),
                                CheckboxListTile(
                                  title: Text("Check-In Status"),
                                  value: _isCheckedIn,
                                  onChanged: (val) {
                                    setState(() {
                                      _isCheckedIn = val;
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: Text("Food 1"),
                                  value: _food1Status,
                                  onChanged: (val) {
                                    setState(() {
                                      _food1Status = val;
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: Text("Food 2"),
                                  value: _food2Status,
                                  onChanged: (val) {
                                    setState(() {
                                      _food2Status = val;
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: Text("Food 3"),
                                  value: _food3Status,
                                  onChanged: (val) {
                                    setState(() {
                                      _food3Status = val;
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: Text("Food 4"),
                                  value: _food4Status,
                                  onChanged: (val) {
                                    setState(() {
                                      _food4Status = val;
                                    });
                                  },
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text('Cancel'),
                                onPressed: () {
                                  setState(() {
                                    _scanResults = null;
                                    stackIndex = 0;
                                  });
                                },
                              ),
                              new FlatButton(
                                child: new Text('Confirm'),
                                onPressed: () {
                                  auth
                                      .clientViaServiceAccount(
                                          accountCredentials, scopes)
                                      .then((onValue) {
                                    sheets.SheetsApi(onValue)
                                        .spreadsheets
                                        .values
                                        .update(
                                            sheets.ValueRange.fromJson({
                                              "values": [
                                                [
                                                  data.values[index - 2][0],
                                                  data.values[index - 2][1],
                                                  data.values[index - 2][2],
                                                  data.values[index - 2][3],
                                                  data.values[index - 2][4],
                                                  _isCheckedIn == true ? 1 : 0,
                                                  _food1Status == true ? 1 : 0,
                                                  _food2Status == true ? 1 : 0,
                                                  _food3Status == true ? 1 : 0,
                                                  _food4Status == true ? 1 : 0,
                                                ]
                                              ]
                                            }),
                                            '1dD94ZpGxgyYovrNs11kOjv6cxj6XtUby7Zqz2TH-exw',
                                            'A$index:J$index',
                                            valueInputOption: "RAW")
                                        .then((onValue) {
                                      setState(() {
                                        _scanResults = null;
                                        stackIndex = 0;
                                      });
                                    });
                                  });
                                },
                              )
                            ],
                          ),
                  ],
                )
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chicken?'),
      ),
      body: _buildImage(),
    );
  }

  @override
  void dispose() {
    _camera.dispose();
    super.dispose();
  }
}