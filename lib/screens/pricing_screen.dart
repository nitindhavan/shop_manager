import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shop_management/models/ProductModel.dart';
import 'package:shop_management/screens/add_product_screen.dart';

class PricingPage extends StatefulWidget {
  const PricingPage({super.key});

  @override
  State<PricingPage> createState() => _PricingPageState();
}

class _PricingPageState extends State<PricingPage> {
  var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    searchController.addListener(() {
      setState(() {
        this;
      });
    });
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Pricing',
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 24,
                    fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.only(left: 16,right: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(controller: searchController,style: TextStyle(fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: Colors.black54)
                      ),),
                  ),
                  Icon(Icons.search,color: Colors.black54,),
                ],
              ),
            ),
            FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if(!snapshot.hasData) return Expanded(child: Center(child: Text('No products'),));
                List<ProductModel> productList=[];
                for(DataSnapshot snap in snapshot.data!.snapshot.children){
                  ProductModel model =ProductModel.fromMap(snap.value as Map);
                  productList.add(model);
                }
                return Expanded(
                  child: ListView.builder(
                    key: Key(searchController.text),
                    itemBuilder: (BuildContext context, int index) {
                      if(!productList[index].name.toLowerCase().contains(searchController.text)) return SizedBox();
                      return GestureDetector(
                        child: Container(
                          height: 60,
                          padding: EdgeInsets.only(left: 16),
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              left: 16, right: 16, top: 8, bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade200,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(productList[index].name,
                                textAlign: TextAlign.start,
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    color: Colors.white),),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text('₹ ${productList[index].price}',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      color: Colors.white),),
                              ),
                            ],
                          ),
                        ),
                      );
                    }, itemCount: productList.length,),
                );
              },future: FirebaseDatabase.instance.ref('products').child(FirebaseAuth.instance.currentUser!.uid).once(),
            ),
            GestureDetector(
              onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterProductPage())),
              child: Container(
                height: 60,
                padding: EdgeInsets.only(left: 16),
                width: double.infinity,
                margin: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(blurRadius: 4,color: Colors.pink)]
                ),
                alignment: Alignment.center,
                child: Text('Add New Product',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
