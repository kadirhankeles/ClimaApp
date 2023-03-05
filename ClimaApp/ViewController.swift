//
//  ViewController.swift
//  ClimaApp
//
//  Created by Kadirhan Keles on 4.03.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempatureLabel: UILabel!
    @IBOutlet weak var searchTextfield: UITextField!
    var sehirAdi = "istanbul"
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeatherData()
        searchTextfield.delegate = self
    }
    
    func fetchWeatherData() {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(sehirAdi)&appid=07de6e352cc77e781ec578c937639967&units=metric")!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                do {
                    let weatherModel = try JSONDecoder().decode(ClimaModel.self, from: data)
                    // WeatherModel'e erişerek verileri kullanabilirsiniz
                    DispatchQueue.main.async {
                        self.cityLabel.text = weatherModel.name
                        self.tempatureLabel.text = String(format: "%.1f", weatherModel.main.temp)
                    }
                    print("City: \(weatherModel.name), Temperature: \(weatherModel.main.temp), \(weatherModel.id)")
                } catch {
                    print("Error: \(error)")
                }
            }
        }
        task.resume()
    }
        


    @IBAction func searchButtonClicked(_ sender: UIButton) {
        searchTextfield.endEditing(true)
        
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //Klavyeyi kapatmamıza yarıyor.
    searchTextfield.endEditing(true)
    return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if searchTextfield.text != nil {
            sehirAdi = searchTextfield.text!
            fetchWeatherData()
        }
    searchTextfield.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    if textField.text != "" {
    return true
    } else {
    textField.placeholder = "Type something"
    return false
    }
    }

    }
    
    
    


