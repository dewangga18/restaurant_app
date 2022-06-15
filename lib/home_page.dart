import 'package:flutter/material.dart';
import 'package:restaurant_app/detail_page.dart';
import 'package:restaurant_app/model/resto.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 15,
            left: 15,
            child: Text(
              'Restaurant',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Positioned(
            top: 45,
            left: 17,
            child: Text(
              'recommendation restaurant for you',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Positioned(
            child: Container(
              margin: const EdgeInsets.only(top: 80),
              child: FutureBuilder<String>(
                future: DefaultAssetBundle.of(context).loadString('asset/local_restaurant.json'),
                builder: (context, snapshot) {
                  final List<Resto> restos = parseResto(snapshot.data);
                  return ListView.builder(
                    itemCount: restos.length,
                    itemBuilder: (context, index) {
                      return _buildRestoItem(context, restos[index]);
                    },
                  );
                },
              ),
            ),
          ),
        ]
      ),
    );
  }

  Widget _buildRestoItem(BuildContext context, Resto resto) {
    return ListTile(
      leading: 
      Hero(
        tag: resto.id,
        child: 
        Image.network(
          resto.pictureId,  
          width: 100, height: 300,
        ),
      ),
      title: Text(resto.name),
      subtitle: 
      // Text(resto.city)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, size: 20, color: Colors.red,),
              Text(resto.city),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.star, size: 20, color: Colors.yellow,),
              Text(resto.rating),
            ],
          )
        ],
      ),
      onTap: (){
        Navigator.pushNamed(
          context, 
          DetailPage.routeName,
          arguments: resto
        );
      },
    );
  }
}
