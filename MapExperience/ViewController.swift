//
//  ViewController.swift
//  MapExperience
//
//  Created by Erendira Cruz Reyes on 28/05/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    var admUbicacion = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        admUbicacion.desiredAccuracy = kCLLocationAccuracyHundredMeters
        admUbicacion.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if CLLocationManager.locationServicesEnabled(){ //verifica si la geolocalizacion esta encendida
            switch admUbicacion.authorizationStatus{
            case .notDetermined: admUbicacion.requestAlwaysAuthorization()
            case .restricted, .denied:
                let alert = UIAlertController(title: "Error", message: "Se requiere su permiso para usar la ubicación, Autoriza ahora?", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "SI", style: UIAlertAction.Style.default, handler: { action in
                                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                        return
                                    }
                                    if UIApplication.shared.canOpenURL(settingsUrl) {
                                        UIApplication.shared.open(settingsUrl, options: [:],completionHandler:nil)
                                    }
                                }))
                                alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
            default: admUbicacion.startUpdatingLocation()
            }
            
        }
        
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
            admUbicacion.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        admUbicacion.stopUpdatingLocation()
        guard let ubicacion = locations.first else {return}
        let ad = UIApplication.shared.delegate as! AppDelegate
        //ad.miUbicacion = ubicacion.coordinate
        let textView = UITextView()
        textView.text = "Usted esta en \(ubicacion.coordinate.latitude), \(ubicacion.coordinate.longitude)"
        textView.frame = self.view.frame.insetBy(dx: 30, dy: 30)
        self.view.addSubview(textView)
        CLGeocoder().reverseGeocodeLocation(ubicacion, completionHandler:{ lugares, error in
                   var direccion = ""
                   if error != nil {
                       print ("no se pudo encontrar la dirección correspondiente a esa coordenada")
                   }
                   else {
                       guard let lugar = lugares?.first else { return }
                       let thoroughfare = (lugar.thoroughfare ?? "")
                       let subThoroughfare = (lugar.subThoroughfare ?? "")
                       let locality = (lugar.locality ?? "")
                       let subLocality = (lugar.subLocality ?? "")
                       let administrativeArea = (lugar.administrativeArea ?? "")
                       let subAdministrativeArea = (lugar.subAdministrativeArea ?? "")
                       let postalCode = (lugar.postalCode ?? "")
                       let country = (lugar.country ?? "")
                       direccion = "Dirección: \(thoroughfare) \(subThoroughfare) \(locality) \(subLocality) \(administrativeArea) \(subAdministrativeArea) \(postalCode) \(country)"
                       print (direccion)
                       textView.text = "Usted está en: \(ubicacion.coordinate.latitude), \(ubicacion.coordinate.longitude)\n" + direccion
                   }
    })
}
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        admUbicacion.stopUpdatingLocation()
    }

}

