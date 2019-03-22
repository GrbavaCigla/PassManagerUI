import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:flutter/rendering.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  debugPaintSizeEnabled = true;

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      home: LoginPage(),
      title: "Android Password Manager",
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> key = GlobalKey();
  var _services = [
    "SteamPowered",
    "Github",
    "Facebook",
    "Instagram",
    "Viber",
    "Tumblr",
    "Spotify",
    "Apple",
    "Microsoft",
    "IBM",
    "Twitter",
    "WhatsApp",
    "Pinterest",
    "YouTube"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountEmail: Text("Name"),
                    accountName: Text("Generic Name"),
                  ),
                  ListTile(
                    title: Text("Log out"),
                    onTap: () {
                      Navigator.pop(context, true);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 3, color: Colors.grey),
                ),
              ),
              child: ListTile(
                onTap: () {},
                title: Text("Settings"),
                trailing: Icon(Icons.settings),
              ),
            ),
          ],
        ),
      ),
      key: key,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        title: Text("Password Manager"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.dehaze),
            onPressed: () {
              key.currentState.openEndDrawer();
            },
          ),
        ],
      ),
      body: Container(
        child: ListView(
          children: _services.map((i) => CustomListTile(i)).toList(),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final String password = "123";
    String passwordToCheck = "";
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(60.0),
                child: FittedBox(
                  child: FlutterLogo(),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Form(
                      key: formKey,
                      child: TextFormField(
                        autovalidate: false,
                        validator: (String arg) {
                          if (password == passwordToCheck) {
                            print("True");
                            return null;
                          } else {
                            print("False");
                            return "Password is incorrect!";
                          }
                        },
                        onSaved: (String val) {
                          passwordToCheck = val;
                        },
                        autocorrect: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Colors.red,
                          prefixIcon: Icon(Icons.vpn_key),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Master Key",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.blue,
                elevation: 1,
                child: Text("Log in"),
                onPressed: () {
                  // print(formKey.currentState.validate());
                  formKey.currentState.save();
                  if (password == passwordToCheck) {
                    formKey.currentState.reset();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  } else {
                    print("false");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  @override
  String serviceName = "";
  CustomListTile(this.serviceName);

  Widget build(BuildContext context) {
    var avatar = CachedNetworkImage(
        imageUrl: "https://logo.clearbit.com/${serviceName.toLowerCase()}.com",
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.error_outline));

    Color foreground;
    if (Theme.of(context).brightness == Brightness.dark) {
      foreground = Colors.white;
    } else {
      foreground = Theme.of(context).primaryColor;
    }
    if (serviceName != "") {
      return Container(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ServicePage(
                    serviceName, "https://www.${serviceName}.com", "password"),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: avatar,
                    ),
                  ),
                ),
                Text(
                  serviceName,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: foreground),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return ListTile();
    }
  }
}

class ServicePage extends StatefulWidget {
  String serviceName;
  String serviceURL;
  String password;
  ServicePage(this.serviceName, this.serviceURL, this.password);
  @override
  _ServicePageState createState() =>
      _ServicePageState(this.serviceName, this.serviceURL, this.password);
}

class _ServicePageState extends State<ServicePage> {
  String serviceName;
  String serviceURL;
  String password;

  _ServicePageState(this.serviceName, this.serviceURL, this.password);
  @override
  Widget build(BuildContext context) {
    var avatar = CachedNetworkImage(
        width: 70,
        height: 70,
        imageUrl: "https://logo.clearbit.com/${serviceName.toLowerCase()}.com",
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.error_outline));
    return SwipeDetector(
      swipeConfiguration:
          SwipeConfiguration(verticalSwipeMaxWidthThreshold: 250),
      onSwipeDown: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(serviceName),
        ),
        body: Stack(
          children: [
            ClipPath(
              clipper: BackgroundClipper(),
              child: Container(color: Colors.blue),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: avatar,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            serviceURL.toLowerCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        // endDrawer: Drawer(),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   child: Icon(Icons.arrow_back),
        // ),
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height / 2);
    path.lineTo(size.width, size.height / 3);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldDelegate) => false;
}
