import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyAppRoute {
  static const String HOME_ROUTE = '/';
  static const String SCREEN_A_ROUTE = '/a';
  static const String SCREEN_B_ROUTE = '/a/b';

  static Map<String, WidgetBuilder> routes() {
    return {
      HOME_ROUTE: (context) => HomePage(),
      SCREEN_A_ROUTE: (context) => ScreenA(),
      SCREEN_B_ROUTE: (context) => ScreenB(
            data: "xxx",
          ),
    };
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME_ROUTE:
        return MaterialPageRoute(
            builder: (BuildContext context) => HomePage(), settings: settings);
        break;
      case SCREEN_A_ROUTE:
        return MaterialPageRoute(
            builder: (BuildContext context) => ScreenA(), settings: settings);
        break;
      case SCREEN_B_ROUTE:
        return MaterialPageRoute(
          builder: (BuildContext context) => ScreenB(
            data: settings.arguments,
          ),
        );
        break;
      default:
        return MaterialPageRoute(
          builder: (BuildContext context) => Text(
            'Unknown route',
          ),
        );
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // routes: MyAppRoute.routes(),
      onGenerateRoute: MyAppRoute.generateRoute,
      initialRoute: MyAppRoute.SCREEN_B_ROUTE,
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
            OutlineButton(
              onPressed: () => _openScreenB(context),
              child: Text("Open Page B with MaterialPageRoute"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _openScreenA(BuildContext context) async {
    var result = await Navigator.pushNamed(
      context,
      MyAppRoute.SCREEN_A_ROUTE,
      arguments: 'This is data from Home Screen',
    );

    if (result != null) _showSnackBar(result);
  }

  Future<void> _openScreenB(BuildContext context) async {
    var result = await Navigator.pushNamed(
      context,
      MyAppRoute.SCREEN_B_ROUTE,
      arguments: 'This is data from Home Screen',
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
