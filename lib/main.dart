import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Treasure Guess',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home:  MyHomePage(title: 'Treasure Guess'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Color> buttonColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
  ];

  int score = 0;
  int incorrectClicks = 0;
  int restarttime =0;
  int _treasure = 0;
  int _guesscount =0;
  Random random = new Random();

  void _generateNewTreasure() {
    setState(() {
      _treasure = random.nextInt(9)+1;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generateNewTreasure;
    // WidgetsBinding.instance.addPostFrameCallback((_) => switcher());
  }
  void showRestartDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations'),
          content: Card(
            child: Image.asset("images/bg2.jpeg"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                });
                Navigator.of(context).pop();
              },
              child: const Text('Thanks')
            ),
          ],
        );
      },
    );
  }
  void showCongratulationDialogg() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Warning",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Maximum Guess (3)',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                   score = score+50;
                   _generateNewTreasure();
                  });
                  Navigator.of(context).pop();
                },
                child: Text('ok '
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  void showFailureDialogg() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sorry!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'You choose wrong guess',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    score = score+50;
                    _generateNewTreasure();
                  });
                  Navigator.of(context).pop();
                },
                child: Text('ok '
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
        centerTitle: true,

      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    height: 100,
                    width: 370,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Click Any Button Below',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 20.0,
                      padding: const EdgeInsets.all(20),
                      children: List.generate(9, (index) {
                        final color = buttonColors[index % buttonColors.length];
                        String buttonText ="?";




                        return ElevatedButton(
                          onPressed: () {
                            if(_guesscount<3) {
                              if (index == _treasure) {
                                showRestartDialog();
                               setState(() {
                                 _guesscount =0;
                                 _treasure =0;

                               });
                              }
                              else {
                                showFailureDialogg();
                                _guesscount++;

                              }
                            }else{

                              showCongratulationDialogg();

                            }
                          },

                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(color)
                          ),
                          child: Text(
                            buttonText,
                            style: TextStyle(fontSize: 30),
                          ),

                        );
                      }),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    Expanded(
                      child: Card(

                        child: InkWell(
                          splashColor: Colors.amber ,

                          onTap: () {
                            setState(() {
                              _generateNewTreasure();
                              score = 0;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.restart_alt,
                                  size: 40,
                                ),
                                Text(
                                  'Restart',
                                  style: TextStyle(fontSize: 30),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        color: Color.fromRGBO(9, 89, 6,44),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [

                              Icon(
                                Icons.numbers,
                                size: 40,
                              ),
                              Text(
                                'Score: ${score}',
                                style: TextStyle(fontSize: 30,
                                color: Colors.white),
                              ),

                            ],

                          ),

                        ),
                      ),
                    )
                  ],

                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
