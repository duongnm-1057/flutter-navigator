import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    switch (state) {
      case AppLifecycleState.resumed:
        //onResumed();
        Toast.show("onResumed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        setState(() {
        });
        break;
      case AppLifecycleState.inactive:
        //onPaused();
        Toast.show("onPaused", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        break;
      case AppLifecycleState.paused:
        //onInactive() app running on background
        Toast.show("onInactive", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        break;
      case AppLifecycleState.detached:
        //onDetached() app killed by user or os
        Toast.show("onDetached", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder(
          future: Future<void>.delayed(Duration(seconds: 2)),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.connectionState == ConnectionState.done) {
              // ignore: missing_return
              return OutlineButton(
                child: Text("Loaded"),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
