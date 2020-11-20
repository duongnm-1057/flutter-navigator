import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Navigator(
                      onGenerateRoute: (route) => MaterialPageRoute(
                        settings: route,
                        builder: (context) => HomePage(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Navigator(
                      onGenerateRoute: (route) => MaterialPageRoute(
                        settings: route,
                        builder: (context) => HomePage(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: HomePage(),
                  ),
                  Expanded(
                    flex: 1,
                    child: HomePage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
              child: Text("Open Page A with MaterialPageRoute"),
            ),
            SizedBox(
              height: 30,
            ),
            OutlineButton(
              onPressed: () => _openScreenB(context),
              child: Text("Open Page B with CupertinoPageRoute"),
            ),
            SizedBox(
              height: 30,
            ),
            OutlineButton(
              onPressed: () => _openScreenBWithCustomPageRoute(context),
              child: Text("Open Page B with CustomPageRoute"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _openScreenA(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ScreenA(),
          settings: RouteSettings(arguments: "This is data from Home Screen")),
    );

    if (result != null) _showSnackBar(result);
  }

  Future<void> _openScreenB(BuildContext context) async {
    String result = await Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => ScreenB(data: 'This is data from Home Screen')),
    );

    if (result != null) _showSnackBar(result);
  }

  Future<void> _openScreenBWithCustomPageRoute(BuildContext context) async {
    String result = await Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) =>
            ScreenB(data: 'This is data from Home Screen'),
        transitionsBuilder: (c, anim, a2, child) => SlideTransition(
            position: anim.drive(
              Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
                  .chain(
                CurveTween(curve: Curves.fastOutSlowIn),
              ),
            ),
            child: child),
        transitionDuration: Duration(milliseconds: 1000),
      ),
    );

    if (result != null) _showSnackBar(result);
  }

  void _showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
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

class ScreenB extends StatelessWidget {
  const ScreenB({this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page B"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(data),
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
