//
//  ViewController.swift
//  Kharlamov_practice
//
//  Created by practice on 24.09.2019.
//  Copyright © 2019 Kharlamov. All rights reserved.
//

import UIKit

class Films {
    var year: String = ""
    var titleRus: String = ""
    var titleEng: String = ""
    var rating: String = ""
    
    // конструктор
    init(yearString: String, titleRusString: String, titleEngString: String, ratingString: String) {
        year = yearString
        titleRus = titleRusString
        titleEng = titleEngString
        rating = ratingString
    }
}

func YearString (year: String) -> String {
    return year
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Локальные данные для проверки
    var FilmsFeed = [
        Films(yearString: "1994", titleRusString: "Побег из Шоушенка", titleEngString: "The Shawshank Redemption", ratingString: "9.2"),
        Films(yearString: "1999", titleRusString: "Зелёная миля", titleEngString: "The Green Mile", ratingString: "9.1"),
        Films(yearString: "1994", titleRusString: "Форрест Гамп", titleEngString: "Forrest Gump", ratingString: "9.0"),
        Films(yearString: "1993", titleRusString: "Список Шиндлера", titleEngString: "Schindler's List", ratingString: "8.9"),
    ]
    
    struct YearSection {
        var year: String
        var headlines: [Films]
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // Откуда берем данные (переменные)
    // Возвращаем количество элементов в массиве
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FilmsFeed.count
    }
    
    // Обработка нажатий на ячейку
    // Вывод названия выбранного фильма в консоль
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(FilmsFeed[indexPath.row].titleRus)
    }
    
    var yearStr: String = ""
    
    // Отрисовка ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "films", for: indexPath) as? FilmsCell
        
        cell?.titleRus.text = FilmsFeed[indexPath.row].titleRus
        cell?.titleEng.text = FilmsFeed[indexPath.row].titleEng
        cell?.rating.text = FilmsFeed[indexPath.row].rating
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return FilmsFeed.count
    }
    
    // Отрисовка заголовка группы ячеек
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return FilmsFeed[section].year
    }
}

// Пользовательские элементы описания
class FilmsCell: UITableViewCell {
    @IBOutlet weak var titleRus: UILabel!
    @IBOutlet weak var titleEng: UILabel!
    @IBOutlet weak var rating: UILabel!
}

