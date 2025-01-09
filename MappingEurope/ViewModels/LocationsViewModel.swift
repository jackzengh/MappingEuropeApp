//
//  LocationsViewModel.swift
//  MappingEurope
//
//  Created by Jack Zheng on 9/1/2025.
//

import Foundation
import MapKit

class LocationsViewModel: ObservableObject {
    
    @Published var locations: [Location]
    
    @Published var mapLocation: Location
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    let mapSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: mapLocation)
    }
    
    private func updateMapRegion(location: Location) {
        mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
    }
}
