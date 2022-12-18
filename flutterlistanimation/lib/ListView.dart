import 'package:flutter/material.dart';

class ListView1 extends StatefulWidget {
  const ListView1({Key? key}) : super(key: key);

  @override
  State<ListView1> createState() => _ListViewState();
}

class _ListViewState extends State<ListView1> {
  final _items = [];
  GlobalKey<AnimatedListState> key = GlobalKey();

  void _additem() {
    _items.insert(0, "Item ${_items.length + 1}");
    key.currentState!.insertItem(0, duration: const Duration(seconds: 1));
  }
  void _removeitem(int index){
    key.currentState!.removeItem(index, (context, animation){
      return SizeTransition(sizeFactor: animation,
      child: const Card(
        margin: EdgeInsets.all(10),
        color: Colors.red,
        child: ListTile(
          title: Text('Deleted',style: TextStyle(fontSize: 24,color: Colors.white),),
        ),
      ),
      );
    },
      duration: const Duration(milliseconds:500)
    );
    _items.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(child: Text('Animated ListView')),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10,),
          Material(
            type: MaterialType.transparency,
            child: Ink(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrange, width: 5),
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(50.0)), //<-- SEE HERE
              child: InkWell(
                borderRadius: BorderRadius.circular(100.0),
                onTap: () {_additem();},
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.add,
                    size: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: AnimatedList(
            key: key,
            initialItemCount: 0,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context,index,animation){
              return SizeTransition(
                key: UniqueKey(),
                sizeFactor: animation,
                child: Card(
                  margin: const EdgeInsets.all(10),
                  color: Colors.black54,
                  child: ListTile(
                    title: Text(_items[index],style:const TextStyle(fontSize: 24,color: Colors.white),),
                    trailing: Material(
                      type: MaterialType.transparency,
                      child: Ink(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.0)), //<-- SEE HERE
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100.0),
                          onTap: () { _removeitem(index);},
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.delete,
                              size: 20.0,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              );
            },
          ))
        ],
      ),
    );
  }
}
