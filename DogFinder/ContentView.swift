//
//  ContentView.swift
//  DogFinder
//
//  Created by Martin Hrbáček on 08.12.2025.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("isDarkOn") private var isDarkOn: Bool = false
    
    @State private var vm = DogListViewModel(fetchService: FetchService())
    
    @State private var searchText: String = ""
    
    var body: some View {
        Group {
            if vm.isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = vm.errorMessage {
                VStack {
                    Text("Error")
                        .font(.headline)
                    Text(errorMessage)
                        .font(.subheadline)
                    Button("Try again") {
                        Task {
                            await vm.loadDog()
                        }
                    }
                }
            } else {
                NavigationStack {
                    List(vm.search(for: searchText)) { dog in
                        NavigationLink(value: dog) {
                            Text(dog.name)
                                .font(.system(size: 18))
                        }
                        .listRowBackground(Color.brown.opacity(0.2))
                    }
                    .listStyle(.plain)
                    .navigationTitle("Dogs")
                    .navigationDestination(for: DogViewModel.self) { dog in
                        // DogDetailView
                        DogDetailView(dog: dog)
                    }
                    .toolbarBackgroundVisibility(.visible, for: .navigationBar)
                    .toolbarBackground(Color.green.opacity(0.2), for: .navigationBar)
                    
                    .searchable(text: $searchText, prompt: "Search dog")
                    .animation(.default, value: searchText)
                    
                    .navigationBarItems(trailing: Button(action: {
                        isDarkOn.toggle()
                    }, label: {
                        Image(systemName: isDarkOn ? "moon.fill" : "sun.max.fill")
                    }))
                }
            }
        }
        .preferredColorScheme(isDarkOn ? .dark : .light)
        .tint(isDarkOn ? .white : .primary)
        .scrollIndicators(.hidden)
        .task {
            await vm.loadDog()
        }
    }
}

#Preview {
    ContentView()
}
