import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  bool toggle=false;

  final TextEditingController _textEditingController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff35132b),
      appBar: AppBar(
        // titleSpacing: 0,
        //  leadingWidth: 33,
        // centerTitle: false,
         automaticallyImplyLeading: false, // Don't show the leading button
        title: toggle==false ? Row (
          children: [
          Container(
          width: 40.0,
          height: 40.0,
          decoration: new BoxDecoration(
              border: Border.all(
                // color: Color.fromARGB(255, 156, 20, 20),
                width: 1,
              ),
              shape: BoxShape.circle,
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/user_placeholder.jpg'),
              )),
          ),
            SizedBox(
              width: 10,
            ),
            Text(
              "People",
              style: TextStyle(color: Colors.white),
            ),
          ],

        ) : Row(
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: new BoxDecoration(
                  border: Border.all(
                    // color: Color.fromARGB(255, 156, 20, 20),
                    width: 1,
                  ),
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/user_placeholder.jpg'),
                  )),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5,0,0,6),
                child: TextField(
                  inputFormatters: [
                    // UpperCaseTextFormatter(),
                  ],
                  controller: _textEditingController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                     contentPadding: EdgeInsets.fromLTRB(12, 4, 0, 0),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(2,16,0,0),
                      child: ImageIcon(AssetImage("assets/images/ic_t_search.png",),size: 4,color: Colors.white,),
                    ),
                    prefixIconConstraints: BoxConstraints(
                    minHeight: 40,
                    minWidth: 40,
                  ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        )),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                    labelText: 'Search',
                    labelStyle: TextStyle(color: Colors.grey,fontSize: 18),
                    alignLabelWithHint: true,
                    floatingLabelBehavior:FloatingLabelBehavior.never,
                    floatingLabelStyle: TextStyle(color: Color(0xffdd3953)),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          toggle==false ?
          InkWell(
            onTap: (){
              setState(() {
                toggle=true;
              });
            },
              child: Image.asset("assets/images/ic_t_search.png",height: 26,width: 26,)) : Text(""),
          SizedBox(
            width: 8,
          )
        ],
        backgroundColor: Color(0xff35132b),
      ),
      body:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
             height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text("NEW PEOPLE",style: TextStyle(color:Colors.white,fontSize: 16,fontWeight: FontWeight.w500),),
            ],
          ),
          SizedBox(
            height: 10,
          ),

          isTablet ?
          SizedBox(
            // height:87,
            height: MediaQuery.of(context).size.height * 0.10,
          child:
          ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: imgList.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                    children: [Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,4,0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.16,
                         height: MediaQuery.of(context).size.height * 0.23,
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
                    ),
                      Positioned(
                        left: 4, bottom: 15, //give the values according to your requirement
                        child:Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.circle_outlined,size: 6,color: Colors.grey,),
                                SizedBox(
                                  width: 3,
                                ),
                                Text("Mayank...",style: TextStyle(color: Colors.white,fontSize: 14),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]
                );
              }),
          )
          : SizedBox(
            // height:87,
            height: MediaQuery.of(context).size.height * 0.1165,
            child:
            ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: imgList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                      children: [Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,4,0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.24,
                          height: MediaQuery.of(context).size.height * 0.23,
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
                      ),
                        Positioned(
                          left: 4, bottom: 15, //give the values according to your requirement
                          child:Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.circle_outlined,size: 6,color: Colors.grey,),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text("Mayank...",style: TextStyle(color: Colors.white,fontSize: 10),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]
                  );
                }),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text("PEOPLE NEARBY",style: TextStyle(color:Colors.white,fontSize: 16,fontWeight: FontWeight.w500),),
            ],
          ),
          SizedBox(
            height: 10,
          ),

          Expanded(
            child:
                isTablet ?
            GridView.builder(
              shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                     // maxCrossAxisExtent: 100,
                     //  childAspectRatio: 50,
                    crossAxisSpacing:7,
                    mainAxisSpacing: 7),
                itemCount: imgList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                  // width: MediaQuery.of(context).size.width * 0.15,
                  //   height: MediaQuery.of(context).size.height * 0.1,
                    // alignment: Alignment.center,
                    decoration: BoxDecoration(
                      // color: Colors.amber,
                      // border: Border.all(color: Colors.red,width: 1),
                        borderRadius: BorderRadius.circular(3)
                    ),
                  // width: MediaQuery.of(context).size.width * 0.15,
                  //   height: MediaQuery.of(context).size.height * 0.1,
                    // alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4), // Image border
                            child: SizedBox.fromSize(
                                size: Size.fromRadius(40), // Image radius
                                child: imgList[index]
                            ),
                          ),
                        ),
                        Positioned(
                          left: 4, bottom: 15, //give the values according to your requirement
                          child:Row(
                            children: [
                              Icon(Icons.circle_outlined,size: 6,color: Colors.grey,),
                              SizedBox(
                                width: 3,
                              ),
                              Text("Mayank...",style: TextStyle(color: Colors.white,fontSize: 15),),
                            ],
                          ),
                        ),  ],

                    ),
                  );
                })
              :   GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        // maxCrossAxisExtent: 100,
                        //   childAspectRatio: 0.025,
                        crossAxisSpacing:4,
                        mainAxisSpacing: 4),
                    itemCount: imgList.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Stack(
                          children: [Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.5,
                            // alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4), // Image border
                              child: SizedBox.fromSize(
                                  size: Size.fromRadius(40), // Image radius
                                  child: imgList[index]
                              ),
                            ),
                            decoration: BoxDecoration(
                              // color: Colors.amber,
                              //   border: Border.all(color: Colors.red,width: 1),
                                borderRadius: BorderRadius.circular(3)),
                          ),
                            Positioned(
                              left: 4, bottom: 15, //give the values according to your requirement
                              child:Row(
                                children: [
                                  Icon(Icons.circle_outlined,size: 6,color: Colors.grey,),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text("Mayank...",style: TextStyle(color: Colors.white,fontSize: 10),),
                                ],
                              ),
                            ),
                          ]
                      );
                    }),

          ),
        ],
      ),

    );
  }
}
