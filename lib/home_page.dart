import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:note_taking/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  TextEditingController notesController = TextEditingController();
  TextEditingController titleController = TextEditingController();


  var notesList = [];
  var titleList = [];
  var categoryList = [];
  var dateList = [];



  late String selectedCategory ;

  String dropdownValue = 'Select Category';

  var category = [
    'Select Category',
    'Todo',
    'Games',
    'Reminder',
    'Fun',
    'Relax',
    'Other',

  ];




  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            backgroundColor: const Color(0XFF97f0ff),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: const EdgeInsets.all(20),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState)  {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 12,),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: DropdownButton(
                        underline: Container(),
                        value: dropdownValue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items:category.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                            selectedCategory=dropdownValue;
                          });
                        },

                      ),
                    ),
                    const SizedBox(height: 12,),
                    TextField(
                      controller: titleController,
                      maxLength: 60,
                      decoration: InputDecoration(
                        labelText: 'Enter the title',
                        labelStyle: const TextStyle(color: Colors.black54),
                        alignLabelWithHint: true,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none
                        ),
                      ),
                    ),
                    const SizedBox(height: 12,),
                    TextField(
                      controller: notesController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: 'Enter the note......',
                        labelStyle: const TextStyle(color: Colors.black54),
                        alignLabelWithHint: true,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none
                        ),
                      ),
                    ),
                  ],
                );
              }
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.white),
                child: const Text("Submit",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                onPressed: () {
                  Navigator.pop(context);
                  String topic = notesController.text;
                  String title = titleController.text;
                  DateTime now = DateTime.now();
                  setState(() {

                    titleList.add(title);
                    notesList.add(topic);
                    dateList.add(now);
                    categoryList.add(selectedCategory);

                    notesController.text="";
                    
                    //(nameList.length>=noOfStaff)?noOfStaff=nameList.length:_showDialog();
                  });
                },
              ),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.white),
                child: const Text('Cancel',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
         // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AdminHomePage()));
        },
            icon: const Icon(Icons.arrow_back, color: Colors.black,)
        ),
        title: const Text('My Notes',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
        centerTitle: true,
        backgroundColor: const Color(0xFFfafafa),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: notesList.length,
        itemBuilder: (context, i) {
          final item = notesList[i];
          return Dismissible(
              key: Key(item),
              direction: DismissDirection.startToEnd,
              onDismissed:(direction){
                setState(() {
                  notesList.removeAt(i);
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$item Removed from list'),
                  ),
                );

              },
              background: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Lottie.network('https://assets1.lottiefiles.com/datafiles/YpOCRxpifd1Xs1n/data.json')),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                child: ListTile(
                  onTap:() {
    // Use Navigator to open the new screen
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => NoteList(title: notesList[i].toString(), note: notesList[i].toString(), date: dateList[i].toString(), category: categoryList[i].toString())),
    );},
                  selectedTileColor: const Color(0XFFBDCDD6),
                  title: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1),
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment:CrossAxisAlignment.center,
                          children: [
                            Text(titleList[i],),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color:const Color(0XFF97f0ff)
                              ),
                              child: Text(categoryList[i],
                              style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10),),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: double.infinity,
                          height: 5,
                        ),
                        Text("Date : ${dateList[i].day}-${dateList[i].month}-${dateList[i].year}",style: const TextStyle(color: Color(0xA6000000)),),
                      ],
                    ),
                  ),
                ),
              )
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        //backgroundColor: Colors.black87 ,
        onPressed: (){
          _showDialog();
        },
        child: const Icon(Icons.add),),
    );
  }
}


class NoteList extends StatelessWidget {
  String title;

  String note;

  String date;

  String category;

   NoteList({Key? key,required this.title,required this.note,required this.date, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color:const Color(0XFF97f0ff)
                    ),
                    child: Text(category,
                      style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10),),
                  )
                ],
              ),
              SizedBox(height: 30,),
              Text(note,)
            ],
          ),

        ),
      ),
    );
  }
}
