import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:currency_exchange/model_class/currency_model.dart';
import 'package:currency_exchange/services/api_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ApiServices apiServices = ApiServices();

  String selectedCurrency = "USD";

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
    return   Scaffold(
      backgroundColor: Colors.black,
      body: Column(
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
              initialValue: 'us',
              itemBuilder: buildDropdownItem,
              onValuePicked: (Country? country) {
                setState(() {
                  selectedCurrency = country?.currencyCode?? "";
                });
              },
            ),
          ),
          const SizedBox(height: 10,),
          const Text("All Currency",style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),),
            const SizedBox(height: 10,),
           FutureBuilder(
             future: apiServices.getLatest(selectedCurrency),
               builder: (context,snapshot){
             if(snapshot.hasData){
               List<CurrencyModel> currencyModelList = snapshot.data?? [];
               return  Expanded(
                 child: ListView.builder(
                   itemCount: currencyModelList.length,
                   itemBuilder: (context, index){

                     /// Refector code
                     // return AllCurrencyListItem(currencyModel:currencyModelList[index]);

                     return  Container(
                       margin: const EdgeInsets.all(10),
                       padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                       height: 45,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: Colors.blue.withAlpha(80),
                       ),
                       child:  Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(
                             currencyModelList[index].code?? " ",
                             style: const TextStyle(
                             fontSize: 16,
                             color: Colors.white,
                             fontWeight: FontWeight.bold,
                           ),),
                           Text(currencyModelList[index].value.toString(),style: const TextStyle(
                             fontSize: 16,
                             color: Colors.white,
                             fontWeight: FontWeight.bold,
                           ))
                         ],
                       ),
                     );
                   },
                 ),
               );
             }

             if(snapshot.hasError){
               return const Center(
                 child: Text("Error occurred",style: TextStyle(
                   color: Colors.white,
                   fontWeight: FontWeight.bold,
                   fontSize: 20,
                 ),),
               );
             }

             return const Center(
               child:CircularProgressIndicator(),);

           })

        ],
      ),
    );
  }
}

