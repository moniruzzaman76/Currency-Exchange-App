import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dropdown.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:currency_exchange/services/api_service.dart';
import 'package:flutter/material.dart';

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({Key? key}) : super(key: key);

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {

  ApiServices apiServices = ApiServices();

  final TextEditingController _editingController = TextEditingController();

  String _selectedBaseCurrency = "USD";
  String _selectedTargetCurrency = "GBP";
  String totalValue  = "";

  bool isVisible = false;

  Widget buildDropdownItem(Country country) => Container(
    child: Row(
      children: [
        CountryPickerUtils.getDefaultFlagImage(country),
        const SizedBox(
          width: 8.0,
        ),
        Text("${country.currencyName}",style: const TextStyle(
          fontSize: 15,
        ),),
      ],
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            const Text("Base Currency",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),),
            const SizedBox(height: 10,),
        Container(
          height: 45,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: CountryPickerDropdown(
            initialValue: 'GB',
            itemBuilder: buildDropdownItem,
            onValuePicked: (Country? country) {
              setState(() {
                isVisible = false;
                _selectedBaseCurrency = country?.currencyCode?? "";
              });
            },
          ),
        ),
            const SizedBox(height: 20,),

            SizedBox(
              width: 300,
              child: TextField(
                controller:_editingController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(40),
                  )
                ),
              ),
            ),

            const SizedBox(height: 16,),
            const Text("All Currency",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),),
            const SizedBox(height: 10,),
            Container(
              height: 45,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: CountryPickerDropdown(
                initialValue: 'GB',
                itemBuilder: buildDropdownItem,
                onValuePicked: (Country? country) {
                  setState(() {
                    isVisible = false;
                    _selectedTargetCurrency = country?.currencyCode?? "";
                  });
                },
              ),
            ),
            const SizedBox(height: 20,),

            Container(
              width: 200,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,),
                  onPressed: () async {
                  if(_editingController.text.isNotEmpty){
                    await ApiServices().getExchange(_selectedBaseCurrency, _selectedTargetCurrency).then((result){
                      isVisible = true;
                      double value = double.parse(_editingController.text);
                      double exchangeRate = double.parse(result[0].value.toString());
                      double total = value * exchangeRate;
                      totalValue  = total.toStringAsFixed(2).toString();
                      if(mounted){
                        setState(() {});
                      }
                    });
                  }
                  },
                child: const Text("Exchange",style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),
            const SizedBox( height: 25,),

            Text("$totalValue $_selectedTargetCurrency",
              style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
              color: Colors.white,
            ),)
          ],
        ),
      ),
    );
  }
}
