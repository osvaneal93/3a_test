

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:prueba_3a/eat_view.dart';

class MatrixView extends StatefulWidget {
  const MatrixView({Key? key}) : super(key: key);

  @override
  State<MatrixView> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MatrixView> with ChangeNotifier {
  late TextEditingController _inputController;
  int? row;
  late List<Widget> widgetRow;
  late List<List<int>> matrix;
  int? totalIsland = 0;
  @override
  void initState() {
    widgetRow = [];
    matrix = [[]];

    _inputController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<List<List<int>>> genericMatrix() async {
      int random() {
        return Random().nextInt(2);
      }

      totalIsland = 0;
      matrix = List.generate(
        row!,
        (i) => List.generate(
          row!,
          (i) => random(),
        ),
      );

      for (var n in matrix) {
        for (var i in n) {
          if (i == 0) {
            totalIsland = totalIsland! + 1;
          }
        }
      }
      return matrix;
    }

    Future<List<Widget>> randomMatrix(List<List<int>> mat) async {
      widgetRow = mat
          .map(
            (column) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: column.map((number) {
                if (number == 0) {
                  return SizedBox(
                    width: 50,
                    height: 50,
                    child: islandItem(context),
                  );
                } else {
                  return Container(
                    width: 50,
                    height: 50,
                    child: seaItem(context),
                  );
                }
              }).toList(),
            ),
          )
          .toList();
      return widgetRow;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              'Bienvenido a IslandMatrixApp',
              style: TextStyle(
                fontSize: 22,
                color: Colors.blue,
              ),
            ),
            
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    hintStyle: const TextStyle(color: Colors.green),
                    hintText: "Matriz de ...",
                    fillColor: Colors.white70),
                keyboardType: TextInputType.number,
                controller: _inputController,
              ),
            ),
            TextButton(
              onPressed: () async {
                if (int.parse(_inputController.text) > 0 &&
                    int.parse(_inputController.text) <= 8) {
                  row = int.parse(_inputController.text);
                  matrix = await genericMatrix();
                  print(matrix);
                  print('TOTAL ISLAS: $totalIsland');

                  setState(() {
                    randomMatrix(matrix);
                  });
                } else {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => AlertDialog(
                            title: Text('Lo sentimos '),
                            content: Text('Solo numeros del 1 al 8'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }, child: Text('Volver'))
                            ],
                          ));
                }
              },
              child: const Text('Generar Matriz'),
            ),
            Center(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: widgetRow,
                    ),
                  )
                ],
              ),
            ),
            
            SizedBox(height: 30),
            Text(
              'Total de Islas: $totalIsland',
              style: TextStyle(fontSize: 20),
            ),
            
            SizedBox(height: 30),
            TextButton(onPressed: (){
              Navigator.pushNamed(context, 'eatView/');
            }, child: Text('zona de Comida ->'))

          ],
        ),
      ),
    );
  }

  Center islandItem(BuildContext context) {
    return Center(
                    child: GestureDetector(
                        onTap: () {
                           showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => AlertDialog(
                          title: Text('UPS!! '),
                          content: Text('El desarrollador sigue buscando como saber la localizacion de este elemento'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                }, child: Text('Volver'))
                          ],
                        ));
                        },
                        child: Image.asset(
                          'assets/islandIcon.png',
                          fit: BoxFit.cover,
                        )),
                  );
  }

  Center seaItem(BuildContext context) {
    return Center(
                    child: GestureDetector(
                        onTap: () {
                           showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => AlertDialog(
                          title: Text('UPS!! '),
                          content: Text('El desarrollador sigue buscando como saber la localizacion de este elemento'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                }, child: Text('Volver'))
                          ],
                        ));
                        },
                        child: Image.asset(
                          'assets/sea.jpg',
                          fit: BoxFit.cover,
                        )),
                  );
  }
}
