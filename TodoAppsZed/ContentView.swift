//
//  ContentView.swift
//  TodoAppsZed
//
//  Created by zero on 16/02/21.
//

import SwiftUI

struct ContentView: View {
    //mengakses core data seperti file "scenedelegate"
    @Environment(\.managedObjectContext) var context
    //properti untuk mendapatkan semua data inputan user dan menyimpannya di todolistitem
    @FetchRequest(fetchRequest: ToDoListItem.getAllToDoListItem()) var items: FetchedResults<ToDoListItem>
    @State var text:String = ""
    //Properti Untuk pesan errorr
    @State private var errorMessage:String=""
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    
    var body: some View {
        //komponen untuk menampilakan informasi di layar
        NavigationView{
            List{
                //section untuk menagani inputan user
                Section(header: Text("New item")){
                    HStack{
                        TextField("Enter New Item...",text:$text)
                        Button(action: {
                            if !text.isEmpty{
                                let newItem = ToDoListItem(context: context)
                                newItem.name = text
                                newItem.createdAt = Date()
                                
                                do{
                                    try context.save()
                                    //menyimpan inputan user
                                }
                                catch{
                                    print(error)
                                    //menangkap pesan error(tidak termasuk properti)
                                }
                            }else{
                                self.errorShowing = true
                                self.errorTitle = "Invalid name"
                                self.errorMessage = "Make sure to enter something for \n the new todo item"
                                //membuat object untuk pesan error
                                //Untuk menampilkan pesan error
                                return
                            }
                        }, label: {
                            Text("Save")
                                .foregroundColor(.blue)
                            //tombol latar belakang
                        })
                        .alert(isPresented: $errorShowing){
                            Alert(title:Text(errorTitle),message: Text(errorMessage),dismissButton: .default(Text("Oke")))
                            //untuk menampilkan pesan error dari object
                        }
                    }
                }
                //section untuk menangani data dari inputan user
                Section{
                    //membuat list dari inputan user
                    ForEach(items){ToDoListItem in
                        VStack(alignment:.leading){
                            HStack{
                                Text(ToDoListItem.name!)
                                    .font(.headline)
                                Text("\(ToDoListItem.createdAt!)")
                            }
                        }
                    }.onDelete(perform: { indexSet in
                        guard let index = indexSet.first else{
                            return
                        }
                        let itemToDoDelete = items[index]
                        //membuat let var yang berisi data inputan user dengan parameter index
                        context.delete(itemToDoDelete)
                        //code untuk mengapus dengan parameter itemtododelete
                        do{
                            try context.save()
                        }
                        catch{
                            print(error)
                        }
                    })
                }
            }
            .navigationTitle("Todo List")
            //Titile
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
