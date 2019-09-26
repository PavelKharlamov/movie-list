//
//  ViewController.swift
//  Kharlamov_practice
//
//  Created by practice on 24.09.2019.
//  Copyright © 2019 Kharlamov. All rights reserved.
//

import UIKit

class Films {
    var year: Int
    var titleRus: String = ""
    var titleEng: String = ""
    var rating: String = ""
    
    // конструктор
    init(yearString: Int, titleRusString: String, titleEngString: String, ratingString: String) {
        year = yearString
        titleRus = titleRusString
        titleEng = titleEngString
        rating = ratingString
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Локальные данные для проверки
    var FilmsFeed = [
        Films(yearString: 1994, titleRusString: "Побег из Шоушенка", titleEngString: "The Shawshank Redemption", ratingString: "9.2"),
        Films(yearString: 1999, titleRusString: "Зелёная миля", titleEngString: "The Green Mile", ratingString: "9.1"),
        Films(yearString: 1994, titleRusString: "Форрест Гамп", titleEngString: "Forrest Gump", ratingString: "9.0"),
        Films(yearString: 1993, titleRusString: "Список Шиндлера", titleEngString: "Schindler's List", ratingString: "8.9"),
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        
        // Подключение внешних данных (.json)
        let url = URL(string: "https://s3-eu-west-1.amazonaws.com/sequeniatesttask/films.json")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("Error")
            }
            else {
                if let content = data {
                    do {
                        // Array
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        print(myJson)
                    }
                    catch {
                        
                    }
                }
            }
            
        }
        task.resume()
        
    }
    
    var filmsSection: Int = 0
    var yearArray = [Int]()
    
    // Откуда берем данные (переменные)
    // Возвращаем количество элементов в массиве
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filmsSection = FilmsFeed.count
        return filmsSection
    }
    
    // Обработка нажатий на ячейку
    // Вывод названия выбранного фильма в консоль
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(FilmsFeed[indexPath.row].titleRus)
    }
    
    // Отрисовка ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "films", for: indexPath) as? FilmsCell
        
        cell?.titleRus.text = FilmsFeed[indexPath.row].titleRus
        cell?.titleEng.text = FilmsFeed[indexPath.row].titleEng
        cell?.rating.text = FilmsFeed[indexPath.row].rating
        
        yearArray = [FilmsFeed[indexPath.row].year]
        print(yearArray)
        
        return cell!
    }
    
    // Количество групп ячеек
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return FilmsFeed.count
    }
    
    // Отрисовка заголовка группы ячеек
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "test"
        // return FilmsFeed[section].year
    }
}

// Пользовательские элементы описания
class FilmsCell: UITableViewCell {
    @IBOutlet weak var titleRus: UILabel!
    @IBOutlet weak var titleEng: UILabel!
    @IBOutlet weak var rating: UILabel!
}

