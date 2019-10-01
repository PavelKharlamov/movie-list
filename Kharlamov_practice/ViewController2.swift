//
//  ViewController2.swift
//  Kharlamov_practice
//
//  Created by practice on 01.10.2019.
//  Copyright © 2019 Kharlamov. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // Количество ячеек
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Отрисовка ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "film", for: indexPath) as? SelectedFilmCell
        
        cell?.titleEng.text = selectedName

        let url = URL(string: selectedImage)
        if let data = try? Data(contentsOf: url!)
        {
            cell?.img.image = UIImage(data: data)
        }
        
        cell?.titleEng.text = selectedName
        cell?.titleRus.text = selectedLocalizedName
        cell?.year.text = String(selectedYear)
        cell?.rating.text = String(selectedRating)
        cell?.descr.text = selectedDescription

        return cell!
    }

}

class SelectedFilmCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleEng: UILabel!
    @IBOutlet weak var titleRus: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var descr: UILabel!
}
