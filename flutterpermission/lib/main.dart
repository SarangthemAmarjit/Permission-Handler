import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PERMISSION APP',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PermissionApp(),
    );
  }
}

class PermissionApp extends StatefulWidget {
  const PermissionApp({Key? key}) : super(key: key);

  @override
  State<PermissionApp> createState() => _PermissionAppState();
}

class _PermissionAppState extends State<PermissionApp> {
  String micstatus = '';
  String camerastatus = '';
  String storagestatus = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Permission'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.mic),
            ),
            onTap: () async {
              PermissionStatus microphoneStatus =
                  await Permission.microphone.request();

              if (microphoneStatus == PermissionStatus.granted) {
                setState(() {
                  micstatus = 'Granted Successfully';
                });
              }
              if (microphoneStatus == PermissionStatus.denied) {
                setState(() {
                  micstatus = 'Denied';
                });

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('This Permission is recommended')));
              }
              if (microphoneStatus == PermissionStatus.permanentlyDenied) {
                openAppSettings();
              }
            },
            title: Text('Mic Permission'),
            subtitle: Text('Status of Permission : $micstatus'),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.camera_alt),
            ),
            onTap: () async {
              PermissionStatus cameraStatus = await Permission.camera.request();

              if (cameraStatus == PermissionStatus.granted) {
                setState(() {
                  camerastatus = 'Granted Successfully';
                });
              }
              if (cameraStatus == PermissionStatus.denied) {
                setState(() {
                  camerastatus = 'Denied';
                });

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('You Need To Provide Camera Permission')));
              }
              if (cameraStatus == PermissionStatus.permanentlyDenied) {
                openAppSettings();
              }
            },
            title: Text('Camera Permission'),
            subtitle: Text('Status of Permission : $camerastatus'),
          ),
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.folder)),
            onTap: () async {
              PermissionStatus storageStatus =
                  await Permission.storage.request();

              if (storageStatus == PermissionStatus.granted) {
                setState(() {
                  storagestatus = 'Granted Successfully';
                });
              }
              if (storageStatus == PermissionStatus.denied) {
                setState(() {
                  storagestatus = 'Denied';
                });

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('This Permission is recommended')));
              }
              if (storageStatus == PermissionStatus.permanentlyDenied) {
                openAppSettings();
              }
            },
            title: Text('Storage Permission'),
            subtitle: Text('Status of Permission : $storagestatus'),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.grid_on_rounded),
            ),
            onTap: () async {
              Map<Permission, PermissionStatus> status = await [
                Permission.camera,
                Permission.microphone,
                Permission.storage
              ].request();

              debugPrint(status.toString());
            },
            title: Text('All Permission'),
            subtitle: Text('Status of All Permission : $micstatus'),
          ),
        ],
      ),
    ));
  }
}
