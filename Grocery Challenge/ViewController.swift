//
//  ViewController.swift
//  Grocery Challenge
//
//  Created by Andrew Crookston on 5/14/18.
//  Copyright © 2018 Instacart. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var table: UITableView!

    var questionArray = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // realizando una instalcia 
        let api = ChallengeAPI()
        api.allQuestionsAsync { (result) in
            switch result {
            case .error(let error):
                print(error)
                
            case .success(let questions):
                // asignado el valor question
                self.questionArray = questions
                // esto es para que aparezca al mismo tiempo en ejecucion
                  DispatchQueue.main.async {
                      self.table.reloadData()
                  }
            }
             
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
        table.delegate = self
        table.dataSource = self
      
    }
    
    // funciones para la tabla
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionArray.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          // creando una celda
          let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = questionArray[indexPath.row].query
          return cell
      }
    
    // click table
    // esta funcion es para dar click a la tabla y pasar a la otra vista
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           performSegue(withIdentifier: "showDetails", sender: self)
       }
       
       // preparando
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let destination = segue.destination as? ImageAnwserViewController {
               // esto es como que esta haciendo una instancia, puedo acceder a los campos de heroViewController con la constante hero
            destination.questionArrayImage = [questionArray[(table.indexPathForSelectedRow?.row)!]]
           }
       }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
