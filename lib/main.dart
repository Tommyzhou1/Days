import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:circular_menu/circular_menu.dart';

void main() {
  runApp(MyApp());
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.7),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);

class Palette {
  static const Color primary = Color(0xFF80CBC4);
}
class PinkyPig {
  static const Color primary = Color(0xFFEF9A9A);
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: generateMaterialColor(Palette.primary),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Days'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _colorName = 'No';
  Color _color = Colors.black;
  int _days = 0;
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        // ignore: non_constant_identifier_names
        var DateNow = new DateTime.now();
        var diff = DateNow.difference(picked).inDays;
        _days = diff;
      });
  }
  // ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text('Days'),
      ),
      body: new Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background1.png"),
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),          
          ),
        ),
        child:Stack(
          children: [
            new Container(
              alignment: Alignment.topCenter,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("$_days days",style: TextStyle(fontSize: 32.0,fontWeight: FontWeight.bold)),
                  SizedBox(height: 30.0,),
                  RaisedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Select date',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                    color: generateMaterialColor(Palette.primary),
                  ),
                ],
              ),
            ),
            new Container(
              child:CircularMenu(
              alignment: Alignment.bottomRight,
              backgroundWidget: Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 28),
                  ),
                ),
              ),
              toggleButtonColor: generateMaterialColor(PinkyPig.primary),
              items: [
                CircularMenuItem(
                    icon: Icons.home,
                    color: Colors.green,
                    onTap: () {
                      setState(() {
                        _color = Colors.green;
                        _colorName = 'Green';
                      });
                    }),
                CircularMenuItem(
                    icon: Icons.search,
                    color: Colors.blue,
                    onTap: () {
                      setState(() {
                        _color = Colors.blue;
                        _colorName = 'Blue';
                      });
                    }),
                CircularMenuItem(
                    icon: Icons.access_alarm_outlined,
                    color: Colors.orange,
                    onTap: () {
                      setState(() {
                        _color = Colors.orange;
                        _colorName = 'Orange';
                      });
                    }),
                CircularMenuItem(
                    icon: Icons.chat,
                    color: Colors.purple,
                    onTap: () {
                      setState(() {
                        _color = Colors.purple;
                        _colorName = 'Purple';
                      });
                    }),
                CircularMenuItem(
                    icon: Icons.notifications,
                    color: Colors.brown,
                    onTap: () {
                      setState(() {
                        _color = Colors.brown;
                        _colorName = 'Brown';
                      });
                    })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
