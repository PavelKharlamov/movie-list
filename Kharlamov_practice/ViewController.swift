//
//  ViewController.swift
//  Kharlamov_practice
//
//  Created by practice on 24.09.2019.
//  Copyright © 2019 Kharlamov. All rights reserved.
//

import UIKit

var filmsArray: Array = [Any]()
var yearsArray: Array = [Int]()
var idArray: Array = [Int]()
var localizedNameArray: Array = [String]()
var nameArray: Array = [String]()
var ratingArray: Array = [Double]()

class Films {
    
    var description: String = ""
    var genres: String = ""
    var id: Int
    var image_url: URL
    var localized_name: String = ""
    var name: String = ""
    var rating: Double
    var year: Int
    
    // конструктор
    init(descriptionString: String, genresString: String, idInt: Int, image_urlURL: URL, localized_nameString: String, nameString: String, ratingDouble: Double, yearInt: Int) {
        description = descriptionString
        genres = genresString
        id = idInt
        image_url = image_urlURL
        localized_name = localized_nameString
        name = nameString
        rating = ratingDouble
        year = yearInt
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
                        // print(myJson)
                        
                        if let films = myJson["films"] as? NSArray {
                            //print(films)
                            filmsArray = films as! [Any]
                            
                            var i = 0
                            var cinema: NSDictionary
                            while i < films.count {
                                cinema = films[i] as! NSDictionary
                                
                                // Массив Year
                                if let year = cinema["year"] {
                                    yearsArray.append(year as! Int)
                                }
                                
                                // Массив ID
                                if let id = cinema["id"] {
                                    idArray.append(id as! Int)
                                }
                                
                                // Массив LocalizedName
                                if let localizedName = cinema["localized_name"] {
                                    localizedNameArray.append(localizedName as! String)
                                }
                                
                                // Массив Name
                                if let name = cinema["name"] {
                                    nameArray.append(name as! String)
                                }
                                
                                // Массив Rating
                                // Проверка на соответствие Double
                                // Если проверка не пройдена? добавляется пустое значение? чтобы не нарушать порядок значений в массиве по отношению к остальным массивам данных
                                if let rating = cinema["rating"] {
                                    if rating is Double {
                                        print(rating)
                                        let raitingDouble = rating as! Double
                                        let raitingDoubleRound = Double(round(1000*raitingDouble)/1000)
                                        ratingArray.append(raitingDoubleRound)
                                    } else {
                                        print("Рейтинг \(i) не обнаружен")
                                        ratingArray.append(0)
                                    }
                                } else {
                                    print("Рейтинг \(i) не обнаружен")
                                    ratingArray.append(0)
                                }
                                
                                // Увеличиваем сч>тчик i на +1
                                i += 1
                            }
                        }
                    }
                    catch {
                        
                    }
                }
            }
        }
        
        // Циклы подключений и подсчёт количества попыток выгрузить данные
        var i = 1
        while filmsArray.count < 1 {
            print("Ошибка. Попытка подключения (\(i))")
            i += 1
            task.resume()
        }
        print("Успешно. Данные выгружены")
    }
    
    // Откуда берем данные (переменные)
    // Возвращаем количество элементов в массиве
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return filmsArray.count
    }
    
    // Обработка нажатий на ячейку
    // Вывод id выбранного фильма в консоль
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(filmsArray[indexPath.row].id)
    }
    
    // Отрисовка ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "films", for: indexPath) as? FilmsCell
        
        cell?.titleRus.text = localizedNameArray[indexPath.row]
        cell?.titleEng.text = nameArray[indexPath.row]
        cell?.rating.text = String(ratingArray[indexPath.row])
        
        return cell!
    }
    
    // Количество групп ячеек
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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

