import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/models/todomodel.dart';
import 'package:todo_list_app/APIs/shared_pref_api.dart';




class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  TextEditingController task =TextEditingController();
  TextEditingController description =TextEditingController();
  TextEditingController date =TextEditingController();
  List<Todomodel> work=[];
  bool loaded = false;
  bool editpressed = false;
  int this_id = 0;


  @override
  void initState() {
    super.initState();
    populateList();
  }

  populateList() async {
    work = await SharedPrefApi().getList();
      setState(() {
        loaded = true;
      });
    
  }

  getid() {
    int max = 0;
    List<int> ids = [];
   
      for (var i in work) {
        ids.add(i.id.toInt());
      }
      for (int i in ids) {
        if (i > max) {
          max = i;
        }
      }
      return max + 1;
    
  }

  deleteTask(int id) {
    for (var i in work) {
      if (i.id == id) {
        work.remove(i);
        break;
      }
    }
    SharedPrefApi().saveList(work);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        toolbarHeight: 35,
        title: Center(
          child: Text("Todo List",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
      ),
      )
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25,top: 10),
                    child: Text("Add Task",
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25,right: 25),
                child: Column(
                  children: [
                    TextFormField(
                      controller: task,
                      decoration: InputDecoration(
                        constraints: BoxConstraints(maxHeight: 55),
                        hintText: 'Enter Task Name',
                        labelText: "Task Name",
                        prefixIcon: Icon(Icons.title_rounded,color: Colors.blue,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: description,
                      minLines: 1,
                      maxLines: 3,
                      decoration: InputDecoration(
                        constraints: BoxConstraints(maxHeight: 55),
                        hintText: 'Enter Description',
                        labelText: "Description",
                        prefixIcon: Icon(Icons.description_rounded,color: Colors.blue,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: date,
                      decoration: InputDecoration(
                        constraints: BoxConstraints(maxHeight: 55),
                        hintText: 'Enter Date',
                        labelText: "Date",
                        prefixIcon: Icon(Icons.date_range_rounded, color: Colors.blue,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )
                      ),
                      
                      readOnly: true,
                      onTap: () async{
                        DateTime? pickedDate =await showDatePicker(
                          context: context, 
                          initialDate: DateTime.now() ,
                          firstDate: DateTime.now(), 
                          lastDate: DateTime(DateTime.now().year+1));
          
                        if(pickedDate !=null){
                          String formatedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                          setState(() {
                            date.text = formatedDate;
                          });
                        }else{
                          if(mounted){}
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Date not selected"))
                          );
                        }
                      },
                    ),
                    SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    TextButton.icon(
                      
                      style: ButtonStyle(
                        
                        backgroundColor: MaterialStatePropertyAll(Colors.lightBlue)
                      ),
                    onPressed: () {
                      if (editpressed == false) {
                                  if (task.text != '') {
                                      if (description.text != '') {
                                        if (date.text != '') {
                                        work.add(Todomodel(
                                            id: getid(),
                                            task: task.text,
                                            description: description.text,
                                            date: date.text,));
                                        SharedPrefApi().saveList(work);
                                        populateList();
                                      } else {
                                        print('date missing');
                                      }
                                    } else {
                                      print('description missing');
                                    }
                                  } else {
                                    print('title missing');
                                  }
                                } else {
                                  if (task.text != '') {
                                    if (description.text != '') {
                                    if (date.text != '') {
                                        SharedPrefApi().updateList(
                                            work,
                                            this_id,
                                            task.text,
                                            description.text,
                                            date.text,
                                            );
                                        setState(() {
                                          this_id = 0;
                                          editpressed = false;
                                          populateList();
                                        });
                                      } else {
                                        print('date missing');
                                      }
                                    } else {
                                      print('description missing');
                                    }
                                  } else {
                                    print('title missing');
                                  }
                                }
                    }, 
                    icon: Icon(Icons.save_alt,color: Colors.white,size: 25,), 
                    label: Text("Save",style: TextStyle(color: Colors.white, fontSize: 20),)),
                    SizedBox(
                      width: 45,
                    ),
                    TextButton.icon(
                      
                      style: ButtonStyle(
                        
                        backgroundColor: MaterialStatePropertyAll(Colors.lightBlue)
                      ),
                    onPressed: () {
                      task.clear();
                      description.clear();
                      date.clear();
                    }, 
                    icon: Icon(Icons.clear_rounded,color: Colors.white,size: 25,), 
                    label: Text("Clear",style: TextStyle(color: Colors.white, fontSize: 20),)),
                  ],
                ),
              )
                  ],
                ),
              ),
              SizedBox(
                height: 4 ,
              ),
              Divider(
                color: Colors.black,
                indent: 15,
                endIndent: 15,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15,top: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Your Tasks List",
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),  
                  ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  // scrollDirection: Axis.vertical,
                  itemCount: work.length,
                  itemBuilder: (context, index){
                    return Slidable(
                      key: Key(work[index].id.toString()),
                      startActionPane: ActionPane(motion: ScrollMotion(), 
                      dismissible: DismissiblePane(
                        key: Key(work[index].id.toString()),
                        onDismissed: (){
                          deleteTask(work[index].id);
                        }),
                      children: [
                        SlidableAction(
                          onPressed: null,
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.lightBlueAccent,
                          icon: Icons.delete,
                          label: "Delete",
                        )
                      ]),
                                
                      endActionPane: ActionPane(motion: ScrollMotion(), 
                      children: [
                        SlidableAction(
                          onPressed: (context){
                            task.text = work[index].task;
                            description.text = work[index].description;
                                date.text = work[index].date;
                                setState(() {
                                  editpressed = true;
                                  this_id = work[index].id;
                                });
                          },
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.lightBlueAccent,
                          icon: Icons.edit,
                          label: "Edit",
                        )
                      ]),
                      child: Card(
                        elevation: 10,
                        color: Colors.blue,
                        margin: EdgeInsets.all(6),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          // height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Task: ${work[index].task}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 4),
                              Text("Deadline: ${work[index].date}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  overflow: TextOverflow.ellipsis),
                            ],
                               ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
        