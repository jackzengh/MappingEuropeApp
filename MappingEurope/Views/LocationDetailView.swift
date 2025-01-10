//
//  LocationDetailView.swift
//  MappingEurope
//
//  Created by Jack Zheng on 9/1/2025.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    let location: Location
    
    var body: some View {
        ScrollView {
            VStack (spacing: 16) {
                imageDetailSection
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
                
                titleDetailSection
                
                Divider()
                
                descriptionDetailSection
            
                Divider()
                
                mapDetailSection
                
            }
        }
        .background(.ultraThinMaterial)
        .ignoresSafeArea(.all)
        .overlay(backButton, alignment: .topLeading)
    }
}


#Preview {
    LocationDetailView(location: LocationsDataService.locations.first!)
        .environmentObject(LocationsViewModel())
}

extension LocationDetailView {
    
    var imageDetailSection: some View {
        TabView {
            // ??? do not understand what 'hashable' is and why id: \.self
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? vm.maxWidthIpad : UIScreen.main.bounds.width)
                    .clipped()
                }
            }
        .tabViewStyle(PageTabViewStyle())
        .frame(height:500)
    }
    
    var titleDetailSection: some View {
        VStack (alignment: .leading){
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    var descriptionDetailSection: some View {
        VStack (alignment: .leading, spacing: 16){
            Text(location.description)
                .font(.subheadline)
            
            if let url = URL(string: location.link) {
                Link("Read more here", destination: url)
                    .font(.headline)
                    .tint(.blue)
            }
        }
        .padding()
        
    }
    
    var mapDetailSection: some View {
            Map(
                coordinateRegion: .constant(
                    MKCoordinateRegion(
                        center: location.coordinates,
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))),
                annotationItems: [location]) { location in
                    MapAnnotation(coordinate: location.coordinates) { LocationAnnotationView()
                            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 0)
                    }
                }
                .allowsHitTesting(false)
                .aspectRatio(1.0, contentMode: .fit)
                .cornerRadius(25)
                .padding(.all, UIDevice.current.userInterfaceIdiom == .pad ? 50 : 8)
    }
    
    private var backButton: some View {
        Button(action: {
            vm.showLocationsSheet = nil
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
                .foregroundColor(.primary)
                .padding(16)
                .background(.ultraThickMaterial)
                .cornerRadius(10)
                .padding()
                
        })
    }
}
