import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {

  late bool isTablet=false;

  @override
  void initState() {
    super.initState();
  }

  void didChangeDependencies() {
    // double ratio = MediaQuery.of(context).size.width / MediaQuery.of(context).size.height;
    if(MediaQuery.of(context).size.width < 480)
      // if( (ratio >= 0.74) && (ratio < 1.5) )
        {
      isTablet = false;
    } else{
      isTablet = true;
    }
    print("working");
    print(isTablet);

    super.didChangeDependencies();
  }
  List imgList = [
    Image.asset('assets/images/dummy-user-six.jpg',fit: BoxFit.fill,),
    Image.asset('assets/images/dummy-user-telev.jpg',fit: BoxFit.fill),
    Image.asset('assets/images/dummy-user-six.jpg',fit: BoxFit.fill),
    Image.asset('assets/images/dummy-user-telev.jpg',fit: BoxFit.fill),
    Image.asset('assets/images/dummy-user-six.jpg',fit: BoxFit.fill,),
    Image.asset('assets/images/dummy-user-telev.jpg',fit: BoxFit.fill),
    Image.asset('assets/images/dummy-user-six.jpg',fit: BoxFit.fill,),
    Image.asset('assets/images/dummy-user-six.jpg',fit: BoxFit.fill),
    // Image.asset('assets/images/dummy-user-one.jpg',fit: BoxFit.fill),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff35132b),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Favourites",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff35132b),
      ),

      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: isTablet ?
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                      // maxCrossAxisExtent: 100,
                      // childAspectRatio: 2.0,
                      crossAxisSpacing:7,
                      mainAxisSpacing: 7),
                  itemCount: imgList.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Stack(
                      children: [Container(
                        // alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4), // Image border
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(48), // Image radius
                            child: imgList[index]
                          ),
                        ),
                        decoration: BoxDecoration(
                            // color: Colors.amber,
                            // border: Border.all(color: Colors.red,width: 1),
                            borderRadius: BorderRadius.circular(3)),
                      ),
                        Positioned(
                          left: 6, bottom: 20, //give the values according to your requirement
                          child:Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                Text("Mayank...",style: TextStyle(color: Colors.white,fontSize: 14),),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: [
                              //     Icon(Icons.circle_outlined,size: 6,color: Colors.grey,),
                              //     SizedBox(
                              //       width:5
                              //     ),
                              //     Text("Offline",style: TextStyle(color: Colors.grey,fontSize: 6),),
                              //   ],
                              // )
                            ],
                          ),
                        ),
                        Positioned(
                            left:6,bottom:8,
                            child:   Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.circle_outlined,size: 6,color: Colors.grey,),
                              SizedBox(
                                width:5
                              ),
                              Text("Offline",style: TextStyle(color: Colors.grey,fontSize: 10),),
                            ],
                          ),
                        ),
                        Positioned(
                          right:4,bottom:8,
                            child: Text("160km away",style: TextStyle(color: Colors.grey,fontSize: 10),))
                      ]
                    );
                  }),
            )
                : Padding(
              padding: const EdgeInsets.all(1.0),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      // maxCrossAxisExtent: 100,
                      // childAspectRatio: 2.0,
                      crossAxisSpacing:4,
                      mainAxisSpacing: 5),
                  itemCount: imgList.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Stack(
                        children: [Container(
                          // alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4), // Image border
                            child: SizedBox.fromSize(
                                size: Size.fromRadius(48), // Image radius
                                child: imgList[index]
                            ),
                          ),
                          decoration: BoxDecoration(
                            // color: Colors.amber,
                            // border: Border.all(color: Colors.red,width: 1),
                              borderRadius: BorderRadius.circular(3)),
                        ),
                          Positioned(
                            left: 4, bottom: 18, //give the values according to your requirement
                            child:Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Mayank...",style: TextStyle(color: Colors.white,fontSize: 10),),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   children: [
                                //     Icon(Icons.circle_outlined,size: 6,color: Colors.grey,),
                                //     SizedBox(
                                //       width:5
                                //     ),
                                //     Text("Offline",style: TextStyle(color: Colors.grey,fontSize: 6),),
                                //   ],
                                // )
                              ],
                            ),
                          ),
                          Positioned(
                            left:4,bottom:8,
                            child:   Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.circle_outlined,size: 6,color: Colors.grey,),
                                SizedBox(
                                    width:5
                                ),
                                Text("Offline",style: TextStyle(color: Colors.grey,fontSize: 6),),
                              ],
                            ),
                          ),
                          Positioned(
                              right:4,bottom:6,
                              child: Text("160km away",style: TextStyle(color: Colors.grey,fontSize: 7),))
                        ]
                    );
                  }),
            )
          ),
        ],
      ),
    );
  }
}
