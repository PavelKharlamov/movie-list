//
//  ViewController2.swift
//  Kharlamov_practice
//
//  Created by practice on 01.10.2019.
//  Copyright © 2019 Kharlamov. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    

    @IBOutlet weak var titleRus: UILabel!
    @IBOutlet weak var titleEng: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var selectedID:String = ""
    var selectedLocalizedName: String = ""
    var selectedName: String = ""
    var selectedYear: Int = 0
    var selectedRating: Double = 0
    var selectedDescription: String = ""
    var selectedImage: String = ""
    
    override func viewDidLoad() {
        
        // Вывод данных о выбранном фильме
        titleRus.text = selectedLocalizedName
        titleEng.text = selectedName
        yearLabel.text = String(selectedYear)
        
        ratingLabel.text = String(selectedRating)
        if selectedRating == 0 {
            ratingLabel.textColor = UIColor.white
        } else if selectedRating < 5 {
            ratingLabel.textColor = UIColor.red
        } else if selectedRating <= 6 {
            ratingLabel.textColor = UIColor.gray
        } else {
            ratingLabel.textColor = UIColor.green
        }
        
        descriptionLabel.text = selectedDescription
        
        // Загрузка изображения в UIImageView
        if selectedImage != "" {
            if selectedImage != "null" {
                if let imgURL: NSURL = NSURL(string: selectedImage) {
                    if let imgData: NSData = NSData(contentsOf: imgURL as URL) {
                        image.image = UIImage(data: imgData as Data)
                    }
                }
            }
        }
    }
}
