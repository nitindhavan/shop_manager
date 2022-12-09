import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shop_management/models/CustomerModel.dart';
import 'package:shop_management/screens/add_customer_screen.dart';
import 'package:shop_management/screens/customer_profile.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
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
              child: const Text(
                'Customers',
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
                    child: TextField(controller: searchController, style: TextStyle(fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
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
                if(!snapshot.hasData) return Expanded(child: Center(child: Text('no customers'),));
                List<CustomerModel> supplierList=[];
                for(DataSnapshot snap in snapshot.data!.snapshot.children){
                  CustomerModel model =CustomerModel.fromMap(snap.value as Map);
                  supplierList.add(model);
                }

                return Expanded(
                  child: ListView.builder(
                    key: Key(searchController.text),
                    itemBuilder: (BuildContext context, int index) {
                      if(!supplierList[index].name.toLowerCase().contains(searchController.text)) return SizedBox();
                      return GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(
                            builder: (context) => CustomerProfilePage(model: supplierList[index],))),
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
                          alignment: Alignment.centerLeft,
                          child: Text(supplierList[index].name,
                            textAlign: TextAlign.start,
                            style: TextStyle(fontWeight: FontWeight.bold,
                                color: Colors.white),),
                        ),
                      );
                    }, itemCount: supplierList.length,),
                );
              },future: FirebaseDatabase.instance.ref('customers').orderByChild('shopUID').equalTo(FirebaseAuth.instance.currentUser!.uid).once(),
            ),
            GestureDetector(
              onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterCustomerPage())),
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
                child: Text('Add new Customer',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
