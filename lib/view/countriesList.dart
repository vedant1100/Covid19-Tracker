import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../services/statesServices.dart';

class countriesList extends StatefulWidget {
  const countriesList({super.key});

  @override
  State<countriesList> createState() => _countriesListState();
}

class _countriesListState extends State<countriesList> with TickerProviderStateMixin{
  TextEditingController searchController = TextEditingController();

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this
  ).. repeat();

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<CountriesServiceProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),

      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
          ),
          Expanded(
              child: FutureBuilder(
                future: api.parseCountryRecords(),
                builder: (context,AsyncSnapshot<List<dynamic>> snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          controller: _controller,
                          color: Colors.white,
                          size: 50,
                        )
                    );
                  }
                  else{
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                        itemBuilder: (context,index){
                        String name=snapshot.data?[index]['country'];
                        return ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: Image.network(
                            snapshot.data?[index]['countryInfo']['flag']??"",
                            height: 150, width: 150,
                          ),
                          title: Text(snapshot.data?[index]['country']),
                          subtitle: Text(snapshot.data![index]['cases'].toString()),
                        );
                        },
                    );
                  }
                }
            )
          )
        ],
      ),
    );
  }
}
