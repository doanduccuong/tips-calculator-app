
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreemState createState() => _MainScreemState();
}

class _MainScreemState extends State<MainScreen> {
  int _tipPercentage = 0;
  int _personCouter = 1;
  double _billAmount = 0.0;
  final Color _purple = Colors.purple;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 122),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20.5),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: _purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total Per Person',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: _purple),
                  ),
                  Text("${calculateTotalPerPerson(_billAmount, _personCouter, _tipPercentage)}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: _purple)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                    color: Colors.blueGrey.shade100, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: _purple),
                    decoration: InputDecoration(
                      prefixText: "Bill Amount",
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (exception) {
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Split",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          setState(
                            () {
                              if (_personCouter > 1) {
                                _personCouter--;
                              }
                            },
                          );
                        },
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            color: _purple.withOpacity(0.1),
                          ),
                          child: Center(
                            child: Text(
                              "-",
                              style: TextStyle(
                                  color: _purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "$_personCouter",
                        style: TextStyle(
                          color: _purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _personCouter++;
                          });
                        },
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            color: _purple.withOpacity(0.1),
                          ),
                          child: Center(
                            child: Text(
                              "+",
                              style: TextStyle(
                                  color: _purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                          ),
                        ),
                      ),
                      //Tips
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Tips",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          " ${calculatorTotalTip(_billAmount, _personCouter, _tipPercentage)}",
                          style: TextStyle(color: _purple, fontSize: 17.0),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  "$_tipPercentage%",
                  style: TextStyle(
                    color: _purple,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Slider(
                    divisions: 5,
                    activeColor: _purple,
                    inactiveColor: Colors.grey,
                    min: 0,
                    max: 100,
                    value: _tipPercentage.toDouble(),
                    onChanged: (double value) {
                      setState(() {
                        _tipPercentage = value.round();
                      });
                    })
              ],
            )
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson(double billAmount, int splitBy,int tipPecentage) {
    var totalPerPerson = (calculatorTotalTip(billAmount, splitBy, tipPecentage) + billAmount) / splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }

  calculatorTotalTip(double billAmount, int splitBy, int tipPecentage) {
    double totalTip = 0.0;
    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {
    } else {
      totalTip = (billAmount * tipPecentage) / 100;
    }
    return totalTip;
  }
}
