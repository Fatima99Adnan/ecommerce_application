import 'package:ecommerce_application/core/viewmodels/productsvm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductsVM>(
      create: (ctx) => ProductsVM()..getProductsFromServer(),
      child: Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Badge(
                  label: Consumer<ProductsVM>(
                    builder: (ctx, i, child) => Text("${i.total}"),
                  ),
                  child: Icon(Icons.shopping_cart),
                ),
              )
            ],
          ),
          floatingActionButton: Consumer<ProductsVM>(
            builder: (ctx, r, child) => FloatingActionButton(
              onPressed: () {
                r.addOne();
              },
              child: Icon(Icons.add),
            ),
          ),
          body: Consumer<ProductsVM>(builder: (ctx, i, child) {
            if (i.allProducts.isEmpty)
              return Center(
                child: CircularProgressIndicator(),
              );
            return ListView.builder(
                itemCount: i.allProducts.length,
                itemBuilder: (ctx, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    height: 120,
                    width: double.infinity,
                    child: Column(
                      children: [
                        ListTile(
                          leading:
                              Image.network(i.allProducts[index].thumbnail!),
                          title: Text(
                            "${i.allProducts[index].title}",
                            style: TextStyle(fontSize: 14),
                          ),
                          subtitle: Text(
                            "${i.allProducts[index].category}",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          trailing: Column(
                            children: [
                              Text(
                                "${i.allProducts[index].price}",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  i.addOne();
                                },
                                child: Icon(
                                  Icons.add_shopping_cart,
                                  color: Color.fromARGB(255, 204, 80, 71),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                });
          })),
    );
  }
}
