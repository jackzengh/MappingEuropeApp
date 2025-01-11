//
//  LocationsView.swift
//  MappingEurope
//
//  Created by Jack Zheng on 9/1/2025.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()
            
            VStack {
                header
                Spacer()
                locationsModal
            }
        }
        .sheet(item: $vm.showLocationsSheet, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }

    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}

// extending on the struct elsewhere
extension LocationsView {
    
    // creating new header subview
    private var header: some View {
        VStack {
            Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
                .animation(.none, value: vm.mapLocation)
            // why maxWidth: .infinity??? and not minWidth???
//                .frame(maxWidth: .infinity)
                .frame(maxWidth: vm.maxWidthIpad)
                .frame(height: 50)
                .overlay(alignment: .leading) {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            vm.toggleLocationsList()
                        }
                    }, label: {
                        Image(systemName: "arrow.down")
                            .foregroundColor(.primary)
                            .padding(.all, 8)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                            .rotationEffect(Angle(degrees:vm.showLocationsList ? 180 : 0))
                    })
                    .padding(.horizontal, 10)
                }
               
            if vm.showLocationsList {
                LocationsListView()
            }
            
        }
        .background(.thickMaterial)
        .foregroundColor(.primary)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
        .cornerRadius(10)
        .padding()
        
    }
    
    private var mapLayer: some View {
        Map(
            coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in MapAnnotation(
                coordinate: location.coordinates) {
                    LocationAnnotationView()
                        .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                        .onTapGesture {
                            // withAnimation call necessary to enable transitions and animations to take effect
                            withAnimation (.easeInOut) {
                                vm.showNextLocation(location: location)
                            }
                        }
                }
            }
            )
    }
    
    private var locationsModal: some View {
        ZStack {
            // ??? Do not understand why this needs to be in a ForEach loop
            ForEach(vm.locations) { location in
                // ??? unsure of the purpose of this if statement
                if vm.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 0)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
        }
    }
    
}
