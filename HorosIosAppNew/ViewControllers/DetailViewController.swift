//
//  DetailViewController.swift
//  HorosIosAppNew
//
//  Created by Mañanas on 31/7/24.
//

import UIKit


// controlador

class DetailViewController: UIViewController {
    
    // conexion entre vista y logica
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var datesLabel: UILabel!
    
   
    @IBOutlet weak var favoriteButtonItem: UIButton!
    
    
    
    var horoscope: Horoscope? = nil
    var isFavorite: Bool = false
    
    let defaults = UserDefaults.standard
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let horoscope = horoscope {
            nameLabel.text = horoscope.name
            logoImageView.image = horoscope.logo
            datesLabel.text = horoscope.dates
            
            isFavorite = defaults.string(forKey: "FAVORITE_HOROSCOPE") == horoscope.id
            setFavoriteIcon()
            
            
            getHoroscopeLuck()
        }
    }
    
    // boton para agregar a favorito
    
    @IBAction func setFavorite(_ sender: Any) {
        if isFavorite {
            defaults.removeObject(forKey: "FAVORITE_HOROSCOPE")
        } else {
            defaults.setValue(horoscope?.id, forKey: "FAVORITE_HOROSCOPE")
        }
        isFavorite = !isFavorite
        setFavoriteIcon()
    }
    
    /*
    let playButton  = UIButton(type: .Custom)
    if let image = UIImage(named: "play.png") {
        playButton.setImage(image, forState: .Normal)
    }*/
    
    
    func setFavoriteIcon(){
        if isFavorite{
            favoriteButtonItem.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButtonItem.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
    }
    
    
    
    
    func getHoroscopeLuck() {
        
        loading.isHidden = false
        Task {
            do {
                let luck = try await HoroscopeProvider.getHoroscopeLuck(horoscopeId: horoscope!.id)
                
                descriptionTextView.text = luck
                
                loading.isHidden = true
            } catch {
                print(error)
            }
        }
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    //END
}



