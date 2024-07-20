import 'package:fl_chart/fl_chart.dart';
import 'presentation/resources/app_resources.dart';
import 'presentation/widgets/indicator.dart';
import 'package:flutter/material.dart';
import 'package:cash_drawer/calculator.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context) {
    final numberOccurrence = CalculatorState.numberOccurrence;
    return Center(
      child: PieChartSample2(numberOccurrence: numberOccurrence),
    );
  }
}

class PieChartSample2 extends StatefulWidget {
  final Map<String, int> numberOccurrence;

  const PieChartSample2({super.key, required this.numberOccurrence});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;
  late Map<String, Color> colors;
  @override void initState() {
    // TODO: implement initState
    super.initState();
    colors = {};
    widget.numberOccurrence.keys.forEach((key){
      colors[key] = AppColors.randomColor();
    });
  }


  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (var entry in widget.numberOccurrence.entries)
                Indicator(color: colors[entry.key]!, text: entry.key, isSquare: true), const SizedBox(height: 4,),
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    List<PieChartSectionData> pieSections = [];
    int index = 0;

    final totalAmount = widget.numberOccurrence.entries
        .map((entry) => double.parse(entry.key) * entry.value)
        .reduce((a, b) => a + b);

    widget.numberOccurrence.forEach((k,v){
        final isTouched = index == touchedIndex;
        final fontSize = isTouched ? 25.0 : 16.0;
        final radius = isTouched ? 60.0 : 50.0;
        const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
        if(totalAmount == 0){
          pieSections.add(
            PieChartSectionData(
              color: colors[k],
              value: 40,
              title: '\$$k',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold,
                color: AppColors.mainTextColor1,
                shadows: shadows,
              ),
            ),
          );
          index += 1;
        }
        else{
          final value = (double.parse(k) * v) / totalAmount * 100;
          pieSections.add(
            PieChartSectionData(
              color: colors[k],
              value: 0,
              title: '\$$k',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold,
                color: AppColors.mainTextColor1,
                shadows: shadows,
              ),
            ),
          );
          index += 1;
        }


    });
    return pieSections;

  }
}
