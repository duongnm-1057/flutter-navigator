import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

final RouteObserver<Route<dynamic>> routeObserver =
    RouteObserver<Route<dynamic>>();

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
      navigatorObservers: <NavigatorObserver>[routeObserver],
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  @override
  void initState() {
    super.initState();
    print('init');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPush() {
    print('didPush');
  }

  @override
  void didPushNext() {
    print('didPushNext');
  }

  @override
  void didPop() {
    print('didPop');
  }

  @override
  void didPopNext() {
    print('didPopNext');
  }

  @override
  void dispose() {
    print('dispose');
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('didBuild');
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlineButton(
              onPressed: () => _openScreenA(context),
              child: Text("Open Page A"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openScreenA(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(),
          settings: RouteSettings(arguments: "This is data from Home Screen")),
    );
  }
}

class ScreenA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(ModalRoute.of(context).settings.arguments.toString()),
            OutlineButton(
              onPressed: () => _returnToHomePage(context),
              child: Text('Return to Home Page'),
            ),
          ],
        ),
      ),
    );
  }

  void _returnToHomePage(BuildContext context) {
    Navigator.pop(context, 'Success');
  }
}
