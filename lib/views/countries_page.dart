import 'package:coviedapp/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesPage extends StatefulWidget {
  const CountriesPage({super.key});

  @override
  State<CountriesPage> createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  TextEditingController searchController = TextEditingController();

   @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("Countries"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      
                    });
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                    focusColor: Colors.blue,
                    hoverColor: Colors.blueGrey,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    hintText: "Search with country name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      
                    )
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: StatesServices().CountriesPageApi(), 
                  builder:(context, AsyncSnapshot<List<dynamic>> snapshot){
                    if(!snapshot.hasData){
                      return ListView.builder(
                        itemCount: 8,
                        itemBuilder:(context,index){
                          
                          return Shimmer.fromColors(baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade300, child: Column(
                            children: [
                              ListTile(
                            title: Container(
                              height: 10,
                              width: 80,
                              color: Colors.white,
                            ),
                            subtitle: Container(
                              height: 10,
                              width: 80,
                              color: Colors.white,
                            ),
                            leading: 
                            Container(
                              height: 50,
                              width: 50,
                              color: Colors.white,
                            ),
                            )  ]
                            )
                            );
                         });
                    }
                    else{
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder:(context,index){
                          String name = snapshot.data![index]['country'];
                          if(searchController.text.isEmpty){
                            return Column(
                            children: [
                              ListTile(
                            title: Text(snapshot.data![index]['country']),
                            subtitle: Text(snapshot.data![index]['cases'].toString()),
                            leading: 
                            Image(
                              height: 50,
                              width: 50,
                              image: NetworkImage(
                                snapshot.data![index]['countryInfo']['flag']
                                 ),
                           ) 
                            )  ]
                            );

                          }
                          else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                            return Column(
                            children: [
                              ListTile(
                            title: Text(snapshot.data![index]['country']),
                            subtitle: Text(snapshot.data![index]['cases'].toString()),
                            leading: 
                            Image(
                              height: 50,
                              width: 50,
                              image: NetworkImage(
                                snapshot.data![index]['countryInfo']['flag']
                                 ),
                           ) 
                            )  ]
                            );

                          }
                          else{
                            return Container();

                          }
                          
                         });
                    }
                  }
                  
                  ),
              )
            ],
          ),
        ),
    );
  }
}