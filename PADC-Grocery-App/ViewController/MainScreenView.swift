
import SwiftUI
import PhotosUI
import Firebase
import FirebaseAnalytics
import SDWebImageSwiftUI

struct MainScreenView: View {
    
    @ObservedObject var viewModel = GroceryViewModel()
    
    //@Binding var isPresented: Bool
    
    @State var isPresentedAddNewView: Bool = false
    
    @State var isPresentedAddPhotoView: Bool = false
    
    @State var imageData: Data?
    
    var body: some View {
        NavigationView{
            List{
                ForEach(viewModel.groceries, id: \.name) { grocery in
                    HStack{
                        
                        AsyncImage(url: URL(string: grocery.image ?? "https://firebasestorage.googleapis.com:443/v0/b/padc-grocery-app-9e039.appspot.com/o/image%2FFF58B09E-7C07-4E88-BE54-1BDF7EB4291F.jpg")!)
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        
//                        WebImage(url: URL(string: grocery.image ?? "https://firebasestorage.googleapis.com:443/v0/b/padc-grocery-app-9e039.appspot.com/o/image%2FFF58B09E-7C07-4E88-BE54-1BDF7EB4291F.jpg")!)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 100, height: 100)
                        
                                                
                        VStack(alignment:.leading){
                            Text(grocery.name ?? "default Name")
                                .fontWeight(.bold)
                                .font(.title)
                            Text("\(grocery.amount ?? "default price") $")
                                .fontWeight(.regular)
                                .padding(.top, 10)
                                .foregroundColor(.secondary)
                            Text(grocery.description ?? "default Description")
                                .fontWeight(.regular)
                                .padding(.top, 10)
                                .foregroundColor(.secondary)
                        }
                        HStack{
                            Button(action: {
                                //doesn't work multiple buttons on swiftui's list in the same row
                            }, label: {
                                Image(systemName: "pencil")
                                    .onTapGesture {
                                        self.isPresentedAddNewView = true
                                        viewModel.editGrocery(
                                            name: grocery.name ?? "",
                                            description: grocery.description ?? "",
                                            amount: grocery.amount ?? ""
                                        )
                                    }
                            })
                            .padding(.trailing, 10)
                            Button {
                                //doesn't work multiple buttons on swiftui's list in the same row
                            } label: {
                                Image(systemName: "icloud.and.arrow.down")
                                    .onTapGesture {
                                        
                                        self.isPresentedAddPhotoView.toggle()
                                        viewModel.groceryName = grocery.name ?? ""
                                        viewModel.groceryAmount = grocery.amount ?? ""
                                        viewModel.groceryDescription = grocery.description ?? ""
                                        
                                    }
                            }
                        }
                    }
                }.onDelete(perform: deleteItem)
            }
            .navigationTitle(viewModel.groceryModel.getAppNameFromRemoteConfig())
            .navigationBarItems(trailing: Button("Add New", action: {
                self.isPresentedAddNewView = true
            }))
            .sheet(isPresented: $isPresentedAddNewView, content: {
                VStack(alignment: .center, spacing: 20){
                    NameTextField(textValue: $viewModel.groceryName)
                    PriceTextField(textValue: $viewModel.groceryAmount)
                    DesTextField(textValue: $viewModel.groceryDescription)
                    HStack{
                        Button(action: {
                            viewModel.groceryName = ""
                            viewModel.groceryDescription = ""
                            viewModel.groceryAmount = ""
                            self.isPresentedAddNewView = false
                        }, label: {
                            Text("Cancel").foregroundColor(.white)
                        })
                        .frame(width: 100, height: 50)
                        .background(.secondary)
                        .border(Color.gray, width: 1)
                        .cornerRadius(10)
                        
                        Button(action: {
                            viewModel.addGrocery()
                            viewModel.groceryName = ""
                            viewModel.groceryDescription = ""
                            viewModel.groceryAmount = ""
                            self.isPresentedAddNewView = false
                        }, label: {
                            Text("Done").foregroundColor(.white)
                        })
                        .frame(width: 100, height: 50)
                        .background(Color.cyan)
                        .border(Color.gray, width: 1)
                        .cornerRadius(10)
                    }
                }
                .padding([.leading,.trailing], 50)
                
                
            })
            .sheet(isPresented: $isPresentedAddPhotoView, content: {
                ImagePicker(image: $imageData, viewModel: self.viewModel)
            })
        }
        
    }
    
    func deleteItem(at offsets: IndexSet){
        let chosenIndex = offsets.map{$0}.first ?? 0
        let chosenGrocery = viewModel.groceries[chosenIndex]
        viewModel.deleteGrocery(grocery: chosenGrocery)
    }
    
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        //MainScreenView(isPresented: .constant(.init(false)))
        MainScreenView()
    }
}


