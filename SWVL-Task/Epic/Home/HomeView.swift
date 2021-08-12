//
//  ContentView.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 10/08/2021.
//

import SwiftUI

struct HomeView: View {
    
    init() {
        let navigationBarApperance = UINavigationBarAppearance()
        navigationBarApperance.configureWithOpaqueBackground()
        navigationBarApperance.shadowColor = .clear
        navigationBarApperance.shadowImage = UIImage()
        navigationBarApperance.backgroundColor = UIColor.systemBackground
        UINavigationBar.appearance().tintColor = .label
        UINavigationBar.appearance().standardAppearance = navigationBarApperance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarApperance
    }
    
    @StateObject var viewModel = HomeViewModel(allMoviesUseCase: AllMoviesUseCase(), filteredMoviesUseCase: FilteredMoviesUseCase())
    @State var searchQuery = ""
    @State var isSearchActive = false
    @State var navBarButtonImageName = "magnifyingglass"
    
    var body: some View {
        
        NavigationView {
            
            
            
            ZStack {
                
                Color(.systemBackground).ignoresSafeArea()
                
                //MARK: - Search TextField
                VStack(alignment: .center) {
                    SearchTextField(searchAction: {
                        viewModel.getFilteredMovies(query: searchQuery)
                        UIApplication.shared.endEditing()
                    }, searchQuery: $searchQuery, isSearchActive: $isSearchActive)
                    
                    Spacer()
                }
                
                //MARK: - all movies list
                List(viewModel.movies, id: \.id) { movie in
                    NavigationLink(
                        destination: MovieDetailsView(movie: movie),
                        label: {
                            MovieCell(name: movie.title, rating: movie.rating, year: movie.year)
                        })
                }
                .opacity(isSearchActive ? 0 : 1)
                .listStyle(PlainListStyle())
                
                
                
                //MARK: - search and filtered movies list
                
                List {
                    
                    ForEach(viewModel.searchedMovies, id: \.id) { group in
                        Section(header: SectionHeaderView(text: "\(group.year)")) {
                            ForEach(group.movies, id: \.id) { movie in
                                NavigationLink(
                                    destination: MovieDetailsView(movie: movie),
                                    label: {
                                        MovieCell(name: movie.title, rating: movie.rating, year: movie.year)
                                    })
                            }
                        }
                    }
                    
                    
                }
                .opacity(!isSearchActive ? 0 : 1)
                .padding(.top, 55)
                .accentColor(.red)
                
                
                
                
                if viewModel.isLoading { LoadingView() }
                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    viewModel.getMovies()
                }
            }
            
            .alert(item: $viewModel.alertItem, content: { item in
                Alert(title: item.title, message: item.message, dismissButton: item.dismissButton)
            })
            .navigationBarTitle("Movies 🍿🍿")
            .navigationBarItems(trailing: Button(action: {
                withAnimation(.linear) {
                    isSearchActive.toggle()
                    searchQuery = ""
                    viewModel.searchedMovies = []
                    UIApplication.shared.endEditing()
                    navBarButtonImageName = isSearchActive ? "xmark" : "magnifyingglass"
                }
            }, label: {
                Image(systemName: navBarButtonImageName).foregroundColor(Color(.label)).scaleEffect(1.5)
            }))
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct SearchTextField: View {
    var searchAction: (() -> Void)
    @Binding var searchQuery: String
    @Binding var isSearchActive: Bool
    
    var body: some View {
        
        HStack(spacing: 15) {
            TextField("search with name...", text: $searchQuery)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .frame(width: DEVICE_WIDHT * 0.6, height: 30)
                .padding()
                .background(
                    Color(.systemGray6)
                        .frame(width: DEVICE_WIDHT * 0.68, height: 40)
                        .cornerRadius(20)
                )
            
            Button(action: {
                searchAction()
            }, label: {
                Text("Search")
            })
        }
        .padding()
        .padding(.top, 10)
        .frame(width: DEVICE_WIDHT , height: isSearchActive ? CGFloat(40) : 0)
        .opacity(isSearchActive ? 1 : 0)
    }
}

struct SectionHeaderView: View {
    
    var text: String
    
    var body: some View {
        
        HStack {
            
            Text(text)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.red)
                .padding(.vertical, 3)
                .padding(.leading, 10)
            
            Spacer()
        }
        .background(Color.clear.frame(width: DEVICE_WIDHT, height: 28, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/))
        
    }
}
