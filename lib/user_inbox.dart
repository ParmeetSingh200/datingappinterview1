import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInbox extends StatefulWidget {
  const UserInbox({Key? key}) : super(key: key);

  @override
  State<UserInbox> createState() => _UserInboxState();
}

class _UserInboxState extends State<UserInbox> {

  bool toggle=false;

  final TextEditingController _textEditingController = TextEditingController();

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
            Text(
              "Inbox",
              style: TextStyle(color: Colors.white),
            ),
          ],

        ) : Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,10),
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
body: Column(
  children: [
    Expanded(
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          border:
                          Border.all(width: 1, color: Color(0xffff6b6b))),
                      child: Image.asset(
                        "assets/images/dummy-user-telev.jpg",
                        height: 10,
                        width: 14,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
                            child: SizedBox(
                              height: 70,
                              child: ListTile(
                                  title: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.circle_outlined,color:Colors.white,size: 8,),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Sam",style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                  subtitle: Text(
                                    "Hi,how are you?",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(thickness: 1,),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          border:
                          Border.all(width: 1, color: Color(0xffff6b6b))),
                      child: Image.asset(
                        "assets/images/dummy-user-telev.jpg",
                        height: 10,
                        width: 14,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
                            child: SizedBox(
                              height: 50,
                              child: ListTile(
                                  title: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.circle_outlined,color:Colors.white,size: 8,),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Ryan",style: TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                  subtitle: Text(
                                    "Hi,whts up?",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Divider(thickness: 1,),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          border:
                          Border.all(width: 1, color: Color(0xffff6b6b))),
                      child: Image.asset(
                        "assets/images/dummy-user-telev.jpg",
                        height: 10,
                        width: 14,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
                            child: SizedBox(
                              height: 50,
                              child: ListTile(
                                  title: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.circle_outlined,color:Colors.white,size: 8,),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Sam",style: TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                  subtitle: Text(
                                    "Hi,whts up?",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Divider(thickness: 1,),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          border:
                          Border.all(width: 1, color: Color(0xffff6b6b))),
                      child: Image.asset(
                        "assets/images/dummy-user-telev.jpg",
                        height: 10,
                        width: 14,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
                            child: SizedBox(
                              height: 50,
                              child: ListTile(
                                  title: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.circle_outlined,color:Colors.white,size: 8,),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Sam",style: TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                  subtitle: Text(
                                    "Hi,whts up?",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Divider(thickness: 1,),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            );
          }),
    ),
  ],
),
    );
  }
}
