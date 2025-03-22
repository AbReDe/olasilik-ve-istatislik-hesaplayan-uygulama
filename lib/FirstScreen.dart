import 'package:flutter/material.dart';

import 'SecondScreen.dart';

class FirstScreen extends StatefulWidget {
  FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<double> itemList = [];
  TextEditingController _controller = TextEditingController();


  double calculateAverage(List<double> list) {
    if (list.isEmpty) {
      return 0.0;
    }
    double sum = list.fold(0.0, (previousValue, element) => previousValue + element);
    return sum / list.length;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Parametreleri Gir')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(itemList[index].toString()),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        itemList.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(labelText: 'sayıları Girin'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      try {
                        double value = double.parse(_controller.text);
                        itemList.add(value);
                        _controller.clear();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Geçersiz sayı girişi')),
                        );
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {

              double average = calculateAverage(itemList);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondScreen(itemList: itemList, average: average),
                ),
              );
            },
            child: Text('Islemlere gec'),
          ),
        ],
      ),
    );
  }
}