//
//  DogDetailView.swift
//  DogFinder
//
//  Created by Martin Hrbáček on 08.12.2025.
//

import SwiftUI

struct DogDetailView: View {
    
    let dog: DogViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text("Basic information")
                        .font(.system(size: 26))
                        .padding(.top)
                    
                    Divider()
                    
                    Group {
                        infoRow(title: "Name:", value: dog.name)
                        infoRow(title: "Bred for:", value: dog.bredFor)
                        infoRow(title: "Life span:", value: dog.lifeSpan)
                        infoRow(title: "Temperament:", value: dog.temperament)
                        infoRow(title: "Origin:", value: dog.origin)
                    }
                    
                    AsyncImage(url: dog.urlImage) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .clipShape(.rect(cornerRadius: 10))
                                .frame(maxWidth: .infinity)
                                .shadow(radius: 30)
                        } else if phase.error != nil {
                            Image(systemName: "exclamationmark.triangle")
                                .frame(maxWidth: .infinity)
                                .frame(height: 250)
                            Text("Image not found, woof!")
                        } else {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .frame(height: 250)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle(dog.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .toolbarBackground(Color.green.opacity(0.2), for: .navigationBar)
        }
        .background(Color.brown.opacity(0.2))
    }
    
    
    private func infoRow(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 18))
                .bold()
            Text(value)
                .font(.system(size: 18))
        }
    }
}

#Preview {
    NavigationStack {
        DogDetailView(dog: .sampleDogDetailView)
    }
}
