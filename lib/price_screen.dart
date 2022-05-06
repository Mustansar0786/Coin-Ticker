import 'package:coin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

List<DropdownMenuItem<String>> dropdownItems = [];

class _PriceScreenState extends State<PriceScreen> {
  /*  not working List<DropdownMenuItem<String>> getDropdrownItem() {
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency + "child"),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return dropdownItems;
  }*/

  DropdownButton androidDropdown() {
    return DropdownButton<String>(
      hint: const Text("Select"),
      value: selectedCurrency,
      onChanged: (value) {
        if (value != null) {
          setState(() {
            selectedCurrency = value;
            print("laskjdflksjdflk:$value");
            getdata();
          });
        }
      },
      items: currenciesList
          .map((e) => DropdownMenuItem<String>(
                child: Text(e),
                value: e,
              ))
          .toList(),
    );
  }

  CupertinoPicker iosPicker() {
    return CupertinoPicker(
      itemExtent: 42,
      onSelectedItemChanged: (selectedIndex) {
        getdata();
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          print("value of index in iospicker:$selectedIndex");
        });
      },
      children: currenciesList.map((e) => Text(e)).toList(),
    );
  }

  String selectedCurrency = 'INR';
  String bitcoinValueInUSD = '?';
  String ethValueInUSD = '?';
  String ltcValueInUSD = '?';

  // //11. Create an async method here await the coin data from coin_data.dart
  // void getData() async {
  //   try {
  //     double data = await CoinData().getrate("USD", "BTC");
  //     //13. We can't await in a setState(). So you have to separate it out into two steps.
  //     setState(() {
  //       bitcoinValueInUSD = data.toStringAsFixed(0);
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   //14. Call getData() when the screen loads up. We can't call CoinData().getCoinData() directly here because we can't make initState() async.
  //   getData();
  // }

  getdata() async {
    var btcData = await CoinData().getrate(selectedCurrency, "BTC");
    var ethData = await CoinData().getrate(selectedCurrency, "ETH");
    var ltcData = await CoinData().getrate(selectedCurrency, "LTC");
    setState(() {
      bitcoinValueInUSD = btcData.toStringAsFixed(0);
      ethValueInUSD = ethData.toStringAsFixed(0);
      ltcValueInUSD = ltcData.toStringAsFixed(0);
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("💰 Coin Ticker"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CoinCard(
                  coin: "BTC",
                  bitcoinValueInUSD: bitcoinValueInUSD,
                  selectedCurrecy: selectedCurrency),
              CoinCard(
                  coin: "ETH",
                  bitcoinValueInUSD: ethValueInUSD,
                  selectedCurrecy: selectedCurrency),
              CoinCard(
                  coin: "LTC",
                  bitcoinValueInUSD: ltcValueInUSD,
                  selectedCurrecy: selectedCurrency),
            ],
          ),
          Container(
              height: 80,
              color: Colors.blueAccent,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 10),
              child: kIsWeb ? androidDropdown() : iosPicker()),
        ],
      ),
    );
  }
}

class CoinCard extends StatelessWidget {
  const CoinCard({
    Key? key,
    required this.bitcoinValueInUSD,
    required this.coin,
    required this.selectedCurrecy,
  }) : super(key: key);

  final String bitcoinValueInUSD;
  final String coin;
  final String selectedCurrecy;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(18, 18, 18, 0),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.lightBlueAccent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28),
        child: Text(
          "1 $coin= $bitcoinValueInUSD  $selectedCurrecy",
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
