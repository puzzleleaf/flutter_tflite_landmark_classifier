import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:landmark_classifier/models/landmark.dart';
import 'package:landmark_classifier/services/classification_service.dart';
import 'package:landmark_classifier/services/image_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ClassificationPage extends StatefulWidget {
  final Landmark landmark;

  const ClassificationPage({Key key, this.landmark}) : super(key: key);

  @override
  _ClassificationPageState createState() => _ClassificationPageState();
}

class _ClassificationPageState extends State<ClassificationPage> {
  ClassificationService _classificationService;
  ImageService _imageService;
  Uint8List userImage;
  List<dynamic> result = [];

  @override
  void initState() {
    super.initState();
    _classificationService = ClassificationService(
      modelPath: 'models/landmarks_classifier_africa.tflite',
      labelPath: 'labels/landmarks_classifier_africa.txt',
    );
    _imageService = ImageService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.2),
        title: Text(widget.landmark.title),
      ),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 350,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: userImage == null
                    ? AssetImage(widget.landmark.image)
                    : MemoryImage(userImage),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.only(top: 340),
            padding: const EdgeInsets.only(
              top: 80,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What is this landmark?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  userImage == null
                      ? Text(
                          'No image selected.',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var i = 0; i < result.length; i++)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${i + 1}. ${result[i]['label']}'),
                                      Text(
                                        '${result[i]['value']}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  RaisedButton(
                                    onPressed: () {
                                      _launchURL(result[i]['label']);
                                    },
                                    child: Text('Search'),
                                  )
                                ],
                              ),
                          ],
                        ),
                ],
              ),
            ),
          ),

          // Camera, Gallery Button
          Container(
            margin: const EdgeInsets.only(top: 310),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  child: RawMaterialButton(
                    onPressed: () async {
                      var imageData = await _imageService.cameraImage();
                      var test = _classificationService.runClassification(
                        imageData: imageData,
                        resultCount: 10,
                      );
                      setState(() {
                        userImage = imageData;
                        result = test;
                      });
                    },
                    elevation: 4.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.camera,
                      size: 35.0,
                      color: Colors.grey,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  width: 80,
                  height: 80,
                  child: RawMaterialButton(
                    onPressed: () async {
                      var imageData = await _imageService.loadImage();
                      var test = await _classificationService.runClassification(
                        imageData: imageData,
                        resultCount: 10,
                      );
                      setState(() {
                        userImage = imageData;
                        result = test;
                      });
                    },
                    elevation: 4.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.image_outlined,
                      size: 35.0,
                      color: Colors.grey,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String landmark) async {
    var url = 'https://google.com/search?q=$landmark';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
