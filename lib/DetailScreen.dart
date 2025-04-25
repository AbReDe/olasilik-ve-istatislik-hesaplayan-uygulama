import 'package:flutter/material.dart';
import 'dart:math';

// math.dart dosyanızı import edin

import 'mymath.dart';

class DetailScreen extends StatefulWidget {
  final int pageNumber;
  final double average;
  final List<double> itemList;

  const DetailScreen({
    Key? key,
    required this.pageNumber,
    required this.average,
    required this.itemList,
  }) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int smallValue = 0;
  int largeValue = 0;
  int count = 0;
  List<int> rastgeleOrneklem = [];
  List<int> sistematikOrneklem = [];

  int sampleSize = 0;
  final TextEditingController _smallValueController = TextEditingController();
  final TextEditingController _largeValueController = TextEditingController();
  final TextEditingController _sampleSizeController = TextEditingController();


  final TextEditingController _countController = TextEditingController();


  final TextEditingController _controller = TextEditingController();

  List<double> getRandomSample(List<double> list, int sampleSize) {
    if (list.isEmpty || sampleSize <= 0) {
      return [];
    }

    final random = Random();
    final sample = <double>[];
    final usedIndices = <int>{};

    if (sampleSize <= list.length) {
      while (sample.length < sampleSize) {
        final randomIndex = random.nextInt(list.length);
        if (!usedIndices.contains(randomIndex)) {
          usedIndices.add(randomIndex);
          sample.add(list[randomIndex]);
        }
      }
    } else {
      for (int i = 0; i < sampleSize; i++) {
        final randomIndex = random.nextInt(list.length);
        sample.add(list[randomIndex]);
      }
    }

    return sample;
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (widget.pageNumber == 1) {
      double mode = calculateMode(widget.itemList);
      double median = calculateMedian(widget.itemList);
      double geometricMean = calculateGeometricMean(widget.itemList).toDouble();
      double harmonicMean = calculateHarmonicMean(widget.itemList).toDouble();

      content = Column(
        children: [
          Text('Ortalama: ${widget.average.toStringAsFixed(2)}'),
          Text('Mod: ${mode.toStringAsFixed(2)}'),
          Text('Medyan: ${median.toStringAsFixed(2)}'),
          Text('Geometrik Ortalama: ${geometricMean.toStringAsFixed(2)}'),
          Text('Harmonik Ortalama: ${harmonicMean.toStringAsFixed(2)}'),
        ],
      );
    }
    else if (widget.pageNumber == 2) {
      content = Column(
        children: [
          TextField(
            controller: _largeValueController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Buyuk N'),
            onChanged: (value) {
              setState(() {
                largeValue = int.tryParse(value) ?? 0;
              });
            },
          ),
          TextField(
            controller: _sampleSizeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Kucuk n'),
            onChanged: (value) {
              setState(() {
                sampleSize = int.tryParse(value) ?? 0;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                sistematikOrneklem = sistematikRastgeleOrnekleme(largeValue, sampleSize);
              });
            },
            child: Text('Sistematik Örnekleme Yap'),
          ),
          if (sistematikOrneklem.isNotEmpty)
            ...sistematikOrneklem.map((value) => Text(value.toString())).toList(),
        ],
      );

    }
    else if (widget.pageNumber == 3) {
      content = Column(
        children: [
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Örnekleme Sayısı Girin'),
            onChanged: (value) {
              setState(() {
                sampleSize = int.tryParse(value) ?? 0;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {

              });
            },
            child: Text('Örnekleme Yap'),
          ),
          if (sampleSize > 0) ...getRandomSample(widget.itemList, sampleSize).map((value) => Text(value.toString())).toList(),
        ],
      );
    }
    else if (widget.pageNumber == 4) {
      final sortedList = sortList(widget.itemList);

      content = Column(
        children: [
          Text('Basit seri'),
          ...sortedList.map((value) => Text(value.toString())).toList(),
        ],
      );


    }
    else if (widget.pageNumber == 5) {
      final frequencyMap = getFrequencySeries(widget.itemList);


      final sortedKeys = frequencyMap.keys.toList()..sort();

      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Frekans serisi'),
          SizedBox(height: 8),
          for (final key in sortedKeys)
            Text('${key}: ${frequencyMap[key]}'),
        ],
      );

    }
    else if (widget.pageNumber == 6) {
      final classCount = calculateClassCount(widget.itemList);
      final classWidth = calculateClassWidth(widget.itemList, classCount);
      final limits = calculateClassLimits(widget.itemList, classWidth, classCount);
      final boundaries = calculateClassBoundaries(limits, classWidth);
      final frequencies = calculateFrequencies(widget.itemList, boundaries);
      final midpoints = calculateMidpoints(limits, classWidth);
      final cumulativeFrequencies = calculateCumulativeFrequencies(frequencies);

      content = Column(
        children: [
          Text(
            'Ekranı Sağa dogru kaydırın',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('Sınıf Limitleri')),
                DataColumn(label: Text('Sınıf Sınırları')),
                DataColumn(label: Text('Frekans')),
                DataColumn(label: Text('Orta Nokta')),
                DataColumn(label: Text('Eklemeli Frekans')),
              ],
              rows: List.generate(classCount, (index) {
                return DataRow(cells: [
                  DataCell(Text('${limits[index]} - ${limits[index] + classWidth}')),
                  DataCell(Text('${boundaries[index * 2]} - ${boundaries[index * 2 + 1]}')),
                  DataCell(Text('${frequencies[index]}')),
                  DataCell(Text('${midpoints[index]}')),
                  DataCell(Text('${cumulativeFrequencies[index]}')),
                ]);
              }),
            ),
          ),
        ],
      );
    }
    else if (widget.pageNumber == 7) {
      content = Column(
        children: [
          TextField(
            controller: _smallValueController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Küçük Değer Girin'),
            onChanged: (value) {
              setState(() {
                smallValue = int.tryParse(value) ?? 0;
              });
            },
          ),
          TextField(
            controller: _largeValueController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Büyük Değer Girin'),
            onChanged: (value) {
              setState(() {
                largeValue = int.tryParse(value) ?? 0;
              });
            },
          ),
          TextField(
            controller: _sampleSizeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Örnek Sayısı Girin'),
            onChanged: (value) {
              setState(() {
                sampleSize = int.tryParse(value) ?? 0;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                rastgeleOrneklem = basitRastgeleOrnekleme(smallValue, largeValue, sampleSize);
              });
            },
            child: Text('Basit Rastgele Örnekleme Yap'),
          ),
          if (rastgeleOrneklem.isNotEmpty)
            ...rastgeleOrneklem.map((value) => Text(value.toString())).toList(),
        ],
      );
    }




    else {
      content = Text('${widget.pageNumber}. Sayfanın İçeriği');
    }

    return Scaffold(
      appBar: AppBar(title: Text('Detay Sayfası ${widget.pageNumber}')),
      body: SingleChildScrollView(
        child: Center(
          child: content,
        ),
      ),
    );
  }
}