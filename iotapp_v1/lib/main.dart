import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_launcher/url_launcher.dart';

final databaseRef = FirebaseDatabase.instance.reference();
final Uri _url = Uri.parse('https://billgenupd.herokuapp.com/');
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(Home());
}
void _launchUrl() async {
  if (!await launchUrl(_url)) throw 'Could not launch $_url';
}
// _launchURL() async {
//   const url = 'https://flutter.io';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _socket1 = false;
  bool _socket2 = false;
  bool _socket3 = false;
  bool _socket4 = false;
  int _s1Db = 0;
  int _s2Db = 0;
  int _s3Db = 0;
  int _s4Db = 0;
  int _timer1 = 0;
  int _timer2 = 0;
  int _timer3 = 0;
  int _timer4 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.greenAccent[400],
        centerTitle: true,
        //foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children: [
                Card(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          "images/powerSocket.jpg",
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                        StreamBuilder(
                            stream: databaseRef.child("").onValue,
                            builder: (context, snapshot) {
                              if (snapshot.hasData && !snapshot.hasError) {
                                _s1Db = snapshot.data.snapshot.value['socket1'];
                                _socket1 = (_s1Db == 0) ? false : true;
                              }

                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SwitchListTile(
                                      title: Text("Socket 1"),
                                      value: _socket1,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _socket1 = value;
                                          databaseRef.child("").update(
                                              {'socket1': (_socket1) ? 1 : 0});
                                        });
                                      }),
                                ],
                              );
                            })
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          "images/powerSocket.jpg",
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                        StreamBuilder(
                            stream: databaseRef.child("").onValue,
                            builder: (context, snapshot) {
                              if (snapshot.hasData && !snapshot.hasError) {
                                _s2Db = snapshot.data.snapshot.value['socket2'];
                                _socket2 = (_s2Db == 0) ? false : true;
                              }

                              return SwitchListTile(
                                  title: Text("Socket 2"),
                                  value: _socket2,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _socket2 = value;
                                      databaseRef.child("").update(
                                          {'socket2': (_socket2) ? 1 : 0});
                                    });
                                  });
                            })
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          "images/powerSocket.jpg",
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                        StreamBuilder(
                            stream: databaseRef.child("").onValue,
                            builder: (context, snapshot) {
                              if (snapshot.hasData && !snapshot.hasError) {
                                _s3Db = snapshot.data.snapshot.value['socket3'];
                                _socket3 = (_s3Db == 0) ? false : true;
                              }

                              return SwitchListTile(
                                  title: Text("Socket 3"),
                                  value: _socket3,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _socket3 = value;
                                      databaseRef.child("").update(
                                          {'socket3': (_socket3) ? 1 : 0});
                                    });
                                  });
                            })
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          "images/powerSocket.jpg",
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                        StreamBuilder(
                            stream: databaseRef.child("").onValue,
                            builder: (context, snapshot) {
                              if (snapshot.hasData && !snapshot.hasError) {
                                _s4Db = snapshot.data.snapshot.value['socket4'];
                                _socket4 = (_s4Db == 0) ? false : true;
                              }

                              return SwitchListTile(
                                  title: Text("Socket 4"),
                                  value: _socket4,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _socket4 = value;
                                      databaseRef.child("").update(
                                          {'socket4': (_socket4) ? 1 : 0});
                                    });
                                  });
                            })
                      ],
                    ),
                  ),
                ),
              ],
              mainAxisSpacing: MediaQuery.of(context).size.height * 0.01,
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01,
                  horizontal: MediaQuery.of(context).size.width * 0.01),
            ),
            ListTile(
                leading: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _timer1++;
                      });
                    },
                    child: Text("+")),
                title: Text("Timer 1"),
                subtitle: Text(_timer1.toString() + " minutes"),
                trailing: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_timer1 == 0) {
                          _timer1 == 0;
                        } else {
                          _timer1--;
                        }
                      });
                    },
                    child: Text("-"))),
            ListTile(
                leading: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _timer2++;
                      });
                    },
                    child: Text("+")),
                title: Text("Timer 2"),
                subtitle: Text(_timer2.toString() + " minutes"),
                trailing: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_timer2 == 0) {
                          _timer2 == 0;
                        } else {
                          _timer1--;
                        }
                      });
                    },
                    child: Text("-"))),
            ListTile(
                leading: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _timer3++;
                      });
                    },
                    child: Text("+")),
                title: Text("Timer 3"),
                subtitle: Text(_timer3.toString() + " minutes"),
                trailing: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_timer3 == 0) {
                          _timer3 == 0;
                        } else {
                          _timer3--;
                        }
                      });
                    },
                    child: Text("-"))),
            ListTile(
                leading: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _timer1++;
                      });
                    },
                    child: Text("+")),
                title: Text("Timer 4"),
                subtitle: Text(_timer4.toString() + " minutes"),
                trailing: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_timer4 == 0) {
                          _timer4 == 0;
                        } else {
                          _timer4--;
                        }
                      });
                    },
                    child: Text("-"))),
                  ListTile(
                    leading: ElevatedButton(
                      onPressed:_launchUrl,
              child: Text('Generate Bill')
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
