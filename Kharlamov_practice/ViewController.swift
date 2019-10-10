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
var yearsUniqueArray: Array = [Int]()

var idArray: Array = [Int]()
var localizedNameArray: Array = [String]()
var nameArray: Array = [String]()
var ratingArray: Array = [Double]()
var descriptionArray: Array = [String]()
var imageArray: Array = [String]()
var sectionName: Int = 0
var numSections: Int = 0

var dictionaryData = [
    "id": Int.self,
    "localized_name": String.self,
    "name": String.self,
    "year": Int.self,
    "rating" : Double.self,
    "image_url" : String.self,
    "description" : String.self,
    ] as [String : Any]



var dictionaryDataArray: Array = [dictionaryData]

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
                        
                        if let films = myJson["films"] as? NSArray {
                            filmsArray = films as! [Any]
                            
                            var i = 0
                            var cinema: NSDictionary
                            
                            while i < filmsArray.count {
                                cinema = filmsArray[i] as! NSDictionary
                                
                                dictionaryDataArray.append(dictionaryData)
                                
                                // Массив Years
                                if let year = cinema["year"] {
                                    yearsArray.append(year as! Int)
                                    
                                    dictionaryDataArray[i].updateValue(yearsArray.last!, forKey: "year")
                                }
                                
                                // Массив ID
                                if let id = cinema["id"] {
                                    idArray.append(id as! Int)
                                    
                                    dictionaryDataArray[i].updateValue(idArray.last!, forKey: "id")
                                }
                                
                                // Массив LocalizedName
                                if let localizedName = cinema["localized_name"] {
                                    localizedNameArray.append(localizedName as! String)
                                    
                                    dictionaryDataArray[i].updateValue(localizedNameArray.last!, forKey: "localized_name")
                                }
                                
                                // Массив Name
                                if let name = cinema["name"] {
                                    nameArray.append(name as! String)
                                    
                                    dictionaryDataArray[i].updateValue(nameArray.last!, forKey: "name")
                                }
                                
                                // Массив Rating
                                // Проверка на соответствие Double
                                // Если проверка не пройдена, добавляется пустое значение, чтобы не нарушать порядок значений в массиве по отношению к остальным массивам данных
                                // Округление значений Double до тысячных
                                if let rating = cinema["rating"] {
                                    if rating is Double {
                                        let raitingDouble = rating as! Double
                                        let raitingDoubleRound = Double(round(1000*raitingDouble)/1000)
                                        ratingArray.append(raitingDoubleRound)
                                        
                                        dictionaryDataArray[i].updateValue(ratingArray.last!, forKey: "rating")
                                    } else {
                                        print("Рейтинг \(i) не обнаружен")
                                        ratingArray.append(0)
                                        dictionaryDataArray[i].updateValue(ratingArray.last!, forKey: "rating")
                                    }
                                } else {
                                    print("Рейтинг \(i) не обнаружен")
                                    ratingArray.append(0)
                                    dictionaryDataArray[i].updateValue(ratingArray.last!, forKey: "rating")
                                }
                                
                                // Массив Description
                                if let description = cinema["description"] {
                                    if description is String {
                                        descriptionArray.append(description as! String)
                                        dictionaryDataArray[i].updateValue(descriptionArray.last!, forKey: "description")
                                    } else {
                                        print("Описание \(i) не обнаружено")
                                        descriptionArray.append("null")
                                        dictionaryDataArray[i].updateValue(descriptionArray.last!, forKey: "description")
                                    }
                                } else {
                                    print("Описание \(i) не обнаружено")
                                    descriptionArray.append("null")
                                    dictionaryDataArray[i].updateValue(descriptionArray.last!, forKey: "description")
                                }
                                
                                // Массив Image
                                if let image = cinema["image_url"] {
                                    if image is String {
                                        imageArray.append(image as! String)
                                        dictionaryDataArray[i].updateValue(imageArray.last!, forKey: "image_url")
                                    } else {
                                        print("Изображение \(i) не обнаружено")
                                        imageArray.append("null")
                                        dictionaryDataArray[i].updateValue(imageArray.last!, forKey: "image_url")
                                    }
                                } else {
                                    print("Изображение \(i) не обнаружено")
                                    imageArray.append("null")
                                    dictionaryDataArray[i].updateValue(imageArray.last!, forKey: "image_url")
                                }
                                
                                // Увеличиваем счeтчик i на +1
                                i += 1
                            }
                            dictionaryDataArray.removeLast()
                            
                            // Сортировка фильмов по рейтингу
                            dictionaryDataArray.sort{
                                ((($0 as Dictionary<String, AnyObject>)["rating"] as? Double)!) > (($1 as Dictionary<String, AnyObject>)["rating"] as! Double)
                            }
                            
                            // Сортировка фильмов по году
                            dictionaryDataArray.sort{
                                ((($0 as Dictionary<String, AnyObject>)["year"] as? Int)!) < (($1 as Dictionary<String, AnyObject>)["year"] as! Int)
                            }
                            
                            // Удаление всех элементов в массивах
                            // Необходимо для добавления новых отсортированных значений
                            nameArray.removeAll()
                            localizedNameArray.removeAll()
                            yearsArray.removeAll()
                            ratingArray.removeAll()
                            descriptionArray.removeAll()
                            imageArray.removeAll()
                            
                            // Перебор словаря и добавление в массивы новых отсортированных значений
                            for dic in dictionaryDataArray {
                                let name = dic["name"] as! String
                                let localName = dic["localized_name"] as! String
                                let year = dic["year"] as! Int
                                let rating = dic["rating"] as! Double
                                let description = dic["description"] as! String
                                let img = dic["image_url"] as! String
                                
                                nameArray.append(name)
                                localizedNameArray.append(localName)
                                yearsArray.append(year)
                                ratingArray.append(rating)
                                descriptionArray.append(description)
                                imageArray.append(img)
                            }
                            
                            
                        }
                    }
                    catch {
                        print("Ошибка. Данные недоступны")
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
        print("Обнаужено \(filmsArray.count) элементов")
        
    }

    // Обработка нажатий на ячейку
    // Вывод id выбранного фильма в консоль
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let vc = storyboard?.instantiateViewController(withIdentifier: "filmViewController") as! ViewController2
        
        // Передача данных в переменные второго экрана
        vc.selectedLocalizedName = localizedNameArray[indexPath.row]
        vc.selectedName = nameArray[indexPath.row]
        vc.selectedYear = yearsArray[indexPath.row]
        vc.selectedRating = ratingArray[indexPath.row]
        vc.selectedDescription = descriptionArray[indexPath.row]
        vc.selectedImage = imageArray[indexPath.row]
        
        // Переход ко второму экрану
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // Отрисовка заголовка группы ячеек
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        //sectionName = yearsUniqueArray[section]
        return String(yearsUniqueArray[section])
    }
    
    // Откуда берем данные (переменные)
    // Возвращаем количество элементов в массиве
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Находим повторяющиеся значения
        // и определяем количество ячеек в каждой секции
        let filmKey = yearsUniqueArray[section]
        var count = 0
        if filmKey != nil {
            for i in yearsArray {
                if i == filmKey {
                    count += 1
                }
            }
            return count
        }
        
        return 0
    }
    
    // Отрисовка ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "films", for: indexPath) as? FilmsCell
        
        cell?.titleRus.text = localizedNameArray[indexPath.row]
        
        let filmKey = yearsUniqueArray[indexPath.section]
        
        cell?.titleRus.text = localizedNameArray[indexPath.row]
        
        // Цвет текста Рейтинг
        if ratingArray[indexPath.row] == 0 {
            cell?.rating.textColor = UIColor.white
        } else if ratingArray[indexPath.row] < 5 {
            cell?.rating.textColor = UIColor.red
        } else if ratingArray[indexPath.row] < 7 {
            cell?.rating.textColor = UIColor.gray
        } else {
            cell?.rating.textColor = UIColor.green
        }
        
        cell?.rating.text = String(ratingArray[indexPath.row])
 
        
        return cell!
    }
    
    
    // Количество групп ячеек
    func numberOfSections(in tableView: UITableView) -> Int {
        // Выборка уникальных значений Years
        yearsUniqueArray = Array(Set(yearsArray))
        
        // Сортировка Years по возрастанию
        yearsUniqueArray.sort(){$0 < $1}
        
        return yearsUniqueArray.count
    }
}

    
// Пользовательские элементы описания
class FilmsCell: UITableViewCell {
    @IBOutlet weak var titleRus: UILabel!
    @IBOutlet weak var titleEng: UILabel!
    @IBOutlet weak var rating: UILabel!
}
