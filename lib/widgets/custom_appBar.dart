import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:free_book/Screens/location_screen.dart';
import 'package:free_book/services/firebase_services.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseService _service = FirebaseService();

    return FutureBuilder<DocumentSnapshot>(
      future: _service.users.doc(_service.user!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Address not selected");
        }

        if (snapshot.hasData) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          if(data['address']==null){
              GeoPoint latLong = data['location'];
              _service.getAddress(latLong.latitude,latLong.longitude).then((adres) {
                return appBar(adres, context);
              });
          }else{
            return appBar(data['address'], context);
          }
        }
        print(snapshot.connectionState);
       return Container(
         height: 56,
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child:  Text("Fetching Location"),
         ),
       );
      },
    );
  }

  Widget appBar(address,context){
    return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: (){
            Navigator.pushNamed(context, LocationScreen.id);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 8,bottom: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.location_solid,
                      color: Colors.black,
                      size: 18,
                    ),
                    Flexible(
                      child: Text(
                        address,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down_outlined,color: Colors.black,size: 18,),
                  ],
                ),
              ),),
          ),
        )
    );
  }
}
