//
//  GetJSON.swift
//  Kharlamov_practice
//
//  Created by practice on 01.10.2019.
//  Copyright © 2019 Kharlamov. All rights reserved.
//

import UIKit

class GetJSON: NSObject {
    func Get() {
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
                                // Если проверка не пройдена, добавляется пустое значение, чтобы не нарушать порядок значений в массиве по отношению к остальным массивам данных
                                // Округление значений Double до тысячных
                                if let rating = cinema["rating"] {
                                    if rating is Double {
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
        print("Обнаужено \(filmsArray.count) элементов")
    }
}
