import 'package:flutter/material.dart';

import 'DetailScreen.dart';

class SecondScreen extends StatelessWidget {
  final List<double> itemList;
  final double average; // Ortalama değeri

  final List<String> buttonNames = [
    'Istatislikler',// 1
    'Sistematik Rasgele Ornekleme belli',// 2
    'Basit Rastgele Örnekleme deger belli',// 3
    'Basit seri',// 4
    'Frekans serisi',// 5
    'Frekans tablosu',//6
    'Basit Rasgele Ornekleme ',//7
    'Standart Sapma',//8
    'Standart Sapma Hesapla',//9
    'OMS',//9
    'Dortte Birlik',//10
    'M3',//11
    'm4'//12
  ];

  SecondScreen({Key? key, required this.itemList, required this.average}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hangi Islemi Yapmak Istiyorsunuz')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ...List.generate(13, (index) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        pageNumber: index + 1,
                        average: average,
                        itemList: itemList, // itemList'i geçirin
                      ),
                    ),
                  );
                },
                child: Text(buttonNames[index]),
              );
            }),
          ],
        ),
      ),
    );
  }
}