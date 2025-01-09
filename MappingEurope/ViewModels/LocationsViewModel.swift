//
//  LocationsViewModel.swift
//  MappingEurope
//
//  Created by Jack Zheng on 9/1/2025.
//

import Foundation
import MapKit

// in the View Models, we are now creating the actual models (i.e. Colosseum, Eiffel Tower, etc.)
// this is done by initialising our models by linking what is in our DataService -> Location Model (notice how our init function links locations = LocationDataService.locations
// we also include here functions to interact with the models and the back-end functionality of our app

class LocationsViewModel: ObservableObject {
    
    @Published var locations: [Location]
    
    @Published var mapLocation: Location {
        // if we set a new mapLocation, it will automatically call the updateMapRegion function
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    @Published var showLocationsList: Bool = false
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    // set mapSpan as a static constant -> it will not change throughout the app
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
    
    func toggleLocationsList() {
            showLocationsList = !showLocationsList
    }
}
