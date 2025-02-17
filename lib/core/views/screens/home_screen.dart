import 'package:ecommerce_application/core/viewmodels/categoryvm.dart';
import 'package:ecommerce_application/core/viewmodels/productsvm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // لون خلفية ناعم
      appBar: AppBar(
        title: Text("ShopEase 🛍️"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        elevation: 0,
          // actions: [
            //   Padding(
            //     padding: EdgeInsets.all(15),
            //     child: Badge(
            //       label: Consumer<ProductsVM>(
            //         builder: (ctx, i, child) => Text("${i.total}"),
            //       ),
            //       child: Icon(Icons.shopping_cart),
            //     ),
            //   )
            // ],
      ),
      body: Column(
        children: [
          // 🟡 قائمة الفئات
          ChangeNotifierProvider<CategoryVM>(
            create: (ctx) => CategoryVM()..getCategoriesFromServer(),
            child: Consumer<CategoryVM>(builder: (ctx, cvm, child) {
              if (cvm.allCategories.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }
              return Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cvm.allCategories.length,
                  itemBuilder: (ctx, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.orange[300], // لون ناعم
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(Icons.category, color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            cvm.allCategories[index].name!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ),

          SizedBox(height: 5),

          // 🛒 قائمة المنتجات (تمتد لملء الشاشة)
          Expanded(
            child: ChangeNotifierProvider<ProductsVM>(
              create: (ctx) => ProductsVM()..getProductsFromServer(),
              child: Consumer<ProductsVM>(
                builder: (ctx, i, child) {
                  if (i.allProducts.isEmpty) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: i.allProducts.length,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    itemBuilder: (ctx, index) {
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // صورة المنتج
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  i.allProducts[index].thumbnail!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 12),

                              // معلومات المنتج
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      i.allProducts[index].title!,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      i.allProducts[index].category!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      "\$${i.allProducts[index].price}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepOrange,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // زر إضافة للسلة
                              InkWell(
                                onTap: () {
                                  i.addOne();
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(Icons.add_shopping_cart,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
