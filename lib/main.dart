import 'dart:io';

import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScreenshotController screenshotController = ScreenshotController();
  AppinioSocialShare appinioSocialShare = AppinioSocialShare();
  Future<void> shareToTelegram(String message, String filePath) async {
    print(filePath);
    String response =
        await appinioSocialShare.shareToTelegram(message, filePath: filePath);
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          Screenshot(
            controller: screenshotController,
            child: Container(
              color: Colors.white,
              child: Center(
                child: Text("Here"),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                await screenshotController
                    .capture()
                    .then((capturedImage) async {
                  final tempDir = await getApplicationDocumentsDirectory();

                  // print(
                  //     "new path: ${tempDir.path.substring(tempDir.path.indexOf('data') + 4)}");
                  final file = File('${tempDir.path}/image.jpg');
                  await file.writeAsBytes(capturedImage!, flush: true);
                  bool isThere =
                      await File('${tempDir.path}/image.png').exists();
                  print(isThere);
                  // print(file.exists());

                  print("path:- ${file.absolute.path}");
                  shareToTelegram("Message Text!!", file.absolute.path);
                });
              },
              child: Text("Click Here")),
        ],
      ),
    );
  }
}
