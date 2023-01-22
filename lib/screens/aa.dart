import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/SignInButton.dart';

class AA extends StatefulWidget {
  const AA({super.key});

  @override
  State<AA> createState() => _AAState();
}

class _AAState extends State<AA> {

  File? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: 
      Stack(children: [
      
          Container(
            child:_image==null? CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 100,
            ):CircleAvatar(
               backgroundImage: FileImage(_image!),
              radius: 100,
            ),
          ),
          Positioned(
            top: 150,
            left: 150,
            child: Transform.scale(scale: 2, child: IconButton(onPressed: (){
showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        )),
                        builder: (context) => DraggableScrollableSheet(
                            initialChildSize: 0.4,
                            maxChildSize: 0.9,
                            minChildSize: 0.32,
                            expand: false,
                            builder: (context, scrollController) {
                              return SingleChildScrollView(
                                controller: scrollController,
                                child: widgetsInBottomSheet(),
                              );
                            }),
                      );

            }, icon:Icon( Icons.camera_enhance_rounded))))
      ],)),
    );

  }


  Widget widgetsInBottomSheet() {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      clipBehavior: Clip.none,
      children: [
        tipOnBottomSheet(),
        Column(children: [
          const SizedBox(
            height: 100,
          ),
          SignInButton(
            onTap: () {
              getImage(true);
              Navigator.pop(context);
            },
            iconPath: 'assets/logos/camera.png',
            textLabel: 'Take from camera',
            backgroundColor: Colors.grey.shade300,
            elevation: 0.0,
          ),
          const SizedBox(
            height: 40,
          ),
          SignInButton(
            onTap: () {
              getImage(false);
              Navigator.pop(context);
            },
            iconPath: 'assets/logos/gallery.png',
            textLabel: 'Take from gallery',
            backgroundColor: Colors.grey.shade300,
            elevation: 0.0,
          ),
        ])
      ],
    );
  }

  Widget tipOnBottomSheet() {
    return Positioned(
      top: -15,
      child: Container(
        width: 60,
        height: 7,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
      ),
    );
  }
  Future getImage(bool FromCamera) async {
       final ImagePicker _picker = ImagePicker();
       final image = await _picker.pickImage(
        source: FromCamera ? ImageSource.camera : ImageSource.gallery);
    if (image == null) {
      return;
    }
    final tempImg = File(image.path);
    setState(() {
      _image = tempImg;
    });
  }
}