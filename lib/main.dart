import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
    );
  }
}

class KSPLayer extends StatefulWidget {
  const KSPLayer({super.key});

  @override
  State<KSPLayer> createState() => _KSPLayerState();
}

class _KSPLayerState extends State<KSPLayer> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: UiKitView(
        onPlatformViewCreated: (id) {},
        viewType: 'KSPLayerView',
        creationParams: <String, String>{
          'videoUrl':
              "https://appx-transcoded-videos.livelearn.in/temp-data/hls-drm-test.m3u8"
        },
        creationParamsCodec: const StandardMessageCodec(),
      ),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => KSPLayer()));
                  },
                  child: Text("Move to player ")),
            )
          ],
        ));
  }
}
