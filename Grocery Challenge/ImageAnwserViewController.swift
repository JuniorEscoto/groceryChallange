//
//  ImageAnwserViewController.swift
//  Grocery Challenge
//
//  Created by junior on 4/28/20.
//  Copyright © 2020 Instacart. All rights reserved.
//

import UIKit
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class ImageAnwserViewController: UIViewController {

    var questionArrayImage = [Question]()
    var imageViewProgramating: UIImageView!
    
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var imagen2: UIImageView!
    @IBOutlet weak var imagen3: UIImageView!
    @IBOutlet weak var imagen4: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
       

        let urlImage =  questionArrayImage[0].answers[0].url
        // let imageURL =  urll
       //  imagen.downloaded(from: url)

        UIImage.asyncFrom(url: urlImage) { [weak self] (result) in
            switch result {
            case .success(let image):
                // programando una imagen sin necesidad de crear un controler desde el storyboard
                self!.imageViewProgramating = UIImageView(frame: CGRect(x: 0, y:95, width: self!.view.frame.width, height: 150))
                self!.imageViewProgramating.image  = image
                
                self!.imageViewProgramating.contentMode = .scaleAspectFit
                self!.view.addSubview(self!.imageViewProgramating)
            case .error (let error):
                print(error)
            }
        }

        imagen2.downloaded(from: questionArrayImage[0].answers[1].url)
        imagen3.downloaded(from: questionArrayImage[0].answers[2].url)
        imagen4.downloaded(from: questionArrayImage[0].answers[3].url)
        
        
      //  let tap = UITapGestureRecognizer(target: self, action: #selector(mostrarAlerta))
//        imagen.addGestureRecognizer(tap)
    }
    
        func Click(_ sender: Any) {
        mostrarAlerta()
    }
    
    @objc func mostrarAlerta()  {
         // este es para el mensaje y el titulo
         let alerta = UIAlertController.init(title: "Alerta", message: "mi primer alerta", preferredStyle:.alert) // alert o actionsheet
         
         
         // estos son como botones que saldran
         alerta.addAction(UIAlertAction.init(title: "Yes", style: .default, handler: {(action: UIAlertAction) in
             print("yes")
         }))
         
         alerta.addAction(UIAlertAction.init(title: "NO", style: .default, handler: {(action: UIAlertAction) in
                    print("NO")
                }))
         
         // esto es esencial para que se muestre la alerta
        self.present(alerta, animated: true){
             print("mostrando")
         }
     
    }
}

