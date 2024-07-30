//
//  ViewController.swift
//  HorosIosAppNew
//
//  Created by Mañanas on 30/7/24.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource {
    
//conection
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var horoscopeList: [Horoscope] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        horoscopeList = HoroscopeProvider.getAllHoroscopes()
        
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           tableView.reloadData()
       }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return horoscopeList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Obtenemos una celda reutilizable desde la tabla con el identificador "cell" o el que hayamos puesto en la celda prototipo
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HoroscopeViewCell
        
        // Obtenemos el horoscopo correspondiente a la posición de la celda
        let horoscope = horoscopeList[indexPath.row]
        
        cell.render(horoscope: horoscope)
        
       /* cell.nameLabel.text = horoscope.name
        cell.datesLabel.text = horoscope.dates
        cell.logoImageView.image = horoscope.logo*/
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Preguntamos cual es el identificador del segue
           if segue.identifier == "navigateToDetail" {
               // Obtenemos el viewController de destino
               let viewController = segue.destination as! DetailViewController
               // Obtenemos la celda seleccionada
               let indexPath = tableView.indexPathForSelectedRow!
               // Asignamos en detalle el horoscopo que corresponde a la celda seleccionada
               viewController.horoscope = horoscopeList[indexPath.row]
               // Deseleccionamos la celda para que no aparezca marcada
               tableView.deselectRow(at: indexPath, animated: false)
           }
       }
    
    
    
    // END OF LINES
}

