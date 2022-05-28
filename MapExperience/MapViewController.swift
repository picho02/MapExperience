//
//  MapViewController.swift
//  MapExperience
//
//  Created by Erendira Cruz Reyes on 28/05/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    var elMapa = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elMapa.frame = self.view.bounds
        self.view.addSubview(elMapa)
        elMapa.mapType = .satellite
        elMapa.delegate = self

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        let ad = UIApplication.shared.delegate as! AppDelegate
        elMapa.setRegion(MKCoordinateRegion(center: ad.miUbicacion, latitudinalMeters: 500, longitudinalMeters: 500), animated: true)
        //Colocando un pin
        let elPin = MKPointAnnotation()
        elPin.coordinate = ad.miUbicacion
        elPin.title = "Coordenada 1"
        elMapa.addAnnotation(elPin)
        let elPin2 = MKPointAnnotation()
        elPin2.coordinate = ad.miUbicacion2
        elPin2.title = "Coordenada 2"
        elMapa.addAnnotation(elPin2)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
