import 'package:bitcoin_ticker/reusable_crypto_currency_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();
  String selectedCurrency = 'AUD';
  Map<String, String> currencies = Map();

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      dropdownItems.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
        getData();
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(
        Text(
          currency,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex];
        getData();
      },
      children: pickerItems,
    );
  }

  void getData() async {
    for (String cryptoCurrency in cryptoList) {
      double doubleValue = await coinData.getCoinData(
          currency: selectedCurrency, cryptoCurrency: cryptoCurrency);

      setState(() {
        this.currencies[cryptoCurrency] = doubleValue.toStringAsFixed(2);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    for (String cCurrency in cryptoList) {
      this.currencies[cCurrency] = '?';
    }
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ReusableCryptoCurrencyCard(
                  cryptoCurrencyValue: this.currencies['BTC'],
                  cryptoCurrency: 'BTC',
                  selectedCurrency: selectedCurrency),
              ReusableCryptoCurrencyCard(
                  cryptoCurrencyValue: this.currencies['ETH'],
                  cryptoCurrency: 'ETH',
                  selectedCurrency: selectedCurrency),
              ReusableCryptoCurrencyCard(
                  cryptoCurrencyValue: this.currencies['LTC'],
                  cryptoCurrency: 'LTC',
                  selectedCurrency: selectedCurrency),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
