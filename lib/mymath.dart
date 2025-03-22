import 'dart:math';

// Mod hesaplama fonksiyonu
double calculateMode(List<double> list) {
  if (list.isEmpty) return 0.0;
  var counts = <double, int>{};
  for (var value in list) {
    counts[value] = (counts[value] ?? 0) + 1;
  }
  double mode = list[0];
  int maxCount = 0;
  counts.forEach((value, count) {
    if (count > maxCount) {
      maxCount = count;
      mode = value;
    }
  });
  return mode;
}





// Medyan hesaplama fonksiyonu
double calculateMedian(List<double> list) {
  if (list.isEmpty) return 0.0;
  var sortedList = List<double>.from(list)..sort();
  int middle = sortedList.length ~/ 2;
  if (sortedList.length % 2 == 0) {
    return (sortedList[middle - 1] + sortedList[middle]) / 2.0;
  } else {
    return sortedList[middle];
  }
}




// Geometrik ortalama hesaplama fonksiyonu
num calculateGeometricMean(List<double> list) {
  if (list.isEmpty) return 0.0;
  double product = list.fold(1.0, (p, element) => p * element);
  return pow(product, 1.0 / list.length);
}




// Harmonik ortalama hesaplama fonksiyonu
double calculateHarmonicMean(List<double> list) {
  if (list.isEmpty) return 0.0;
  double sumOfInverses = list.fold(0.0, (p, element) => p + 1 / element);
  return list.length / sumOfInverses;
}






//Basit random deger veren fonksiyon
List<double> getRandomSample(List<double> list, int sampleSize) {
  if (list.isEmpty || sampleSize <= 0) {
    return [];
  }
  final random = Random();
  final sample = <double>[];
  final usedIndices = <int>{};

  if (sampleSize <= list.length) {
    // Aynı elemanları tekrar etme
    while (sample.length < sampleSize) {
      final randomIndex = random.nextInt(list.length);
      if (!usedIndices.contains(randomIndex)) {
        usedIndices.add(randomIndex);
        sample.add(list[randomIndex]);
      }
    }
  } else {
    // Aynı elemanları tekrar et
    for (int i = 0; i < sampleSize; i++) {
      final randomIndex = random.nextInt(list.length);
      sample.add(list[randomIndex]);
    }
  }

  return sample;
}






List<double> getSequentialSample(List<double> list, int sampleSize) {
  if (list.isEmpty || sampleSize <= 0 || sampleSize > list.length) {
    return [];
  }

  return list.sublist(0, sampleSize);
}





Map<double, int> getFrequencySeries(List<double> list) {
  final frequencyMap = <double, int>{};

  for (final value in list) {
    frequencyMap.update(value, (count) => count + 1, ifAbsent: () => 1);
  }

  return frequencyMap;
}





List<int> generateRandomIntValues(int smallValue, int largeValue, int count) {
  if (smallValue >= largeValue || count <= 0) {
    return [];
  }

  final random = Random();
  final values = <int>[];
  for (int i = 0; i < count; i++) {
    values.add(smallValue + random.nextInt(largeValue - smallValue + 1));
  }
  return values;
}


List<int> generateSystematicSample(int smallValue, int largeValue, int sampleSize) {
  if (smallValue >= largeValue || sampleSize <= 0 || (largeValue - smallValue + 1) < sampleSize) {
    return [];
  }

  final random = Random();
  final interval = (largeValue - smallValue + 1) ~/ sampleSize;
  var startIndex = smallValue + random.nextInt(interval);
  final values = <int>[];

  for (int i = 0; i < sampleSize; i++) {
    values.add(startIndex);
    startIndex += interval;
  }
  return values;
}

int calculateClassCount(List<double> list) {
  final n = list.length;
  return (sqrt(n)).ceil();
}

double calculateClassWidth(List<double> list, int classCount) {
  double min = list.reduce((a, b) => a < b ? a : b);
  double max = list.reduce((a, b) => a > b ? a : b);
  final range = max - min;
  return (range / classCount).ceilToDouble();
}

List<double> calculateClassLimits(List<double> list, double classWidth, int classCount) {
  double min = list.reduce((a, b) => a < b ? a : b);
  final limits = <double>[];
  for (int i = 0; i < classCount; i++) {
    limits.add(min + i * classWidth);
  }
  return limits;
}

List<double> calculateClassBoundaries(List<double> limits, double classWidth) {
  final boundaries = <double>[];
  for (int i = 0; i < limits.length; i++) {
    boundaries.add(limits[i] - 0.5); // Alt sınır
    boundaries.add(limits[i] + classWidth - 0.5); // Üst sınır
  }
  return boundaries;
}

List<int> calculateFrequencies(List<double> list, List<double> boundaries) {
  final frequencies = List<int>.filled(boundaries.length ~/ 2, 0);
  for (final value in list) {
    for (int i = 0; i < boundaries.length; i += 2) {
      if (value >= boundaries[i] && value < boundaries[i + 1]) {
        frequencies[i ~/ 2]++;
        break;
      }
    }
  }
  return frequencies;
}
List<double> calculateMidpoints(List<double> limits, double classWidth) {
  final midpoints = <double>[];
  for (final limit in limits) {
    midpoints.add(limit + classWidth / 2);
  }
  return midpoints;
}

List<int> calculateCumulativeFrequencies(List<int> frequencies) {
  final cumulativeFrequencies = <int>[];
  int sum = 0;
  for (final frequency in frequencies) {
    sum += frequency;
    cumulativeFrequencies.add(sum);
  }
  return cumulativeFrequencies;
}