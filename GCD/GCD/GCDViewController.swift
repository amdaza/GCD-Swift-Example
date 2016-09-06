//
//  GCDViewController.swift
//  GCD
//
//  Created by Home on 6/9/16.
//  Copyright © 2016 Alicia. All rights reserved.
//

import UIKit

class GCDViewController: UIViewController {
    
    let url = URL(string: "https://microcambiosdeladensidaddelaire.files.wordpress.com/2015/05/bpctmue.jpg")!

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func syncDownload(_ sender: AnyObject) {
        
        var data : Data
        do {
            try data = Data(contentsOf: url)
            imageView.image = UIImage(data: data)
            
        } catch {
            print("Se fue a la puta")
        }
    }
    
    @IBAction func asyncDownload(_ sender: AnyObject) {
        /*
        
        
        DispatchQueue.global(qos: .userInitiated).async {
           
            var data : Data
            do {
                try data = Data(contentsOf: self.url)
                    
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
                    
            } catch {
                print("Se fue a la puta")
            }
        }
 */
        
        withURL(url) { (img : UIImage) in
            self.imageView.image = img
        }
    }
    
    @IBAction func actorDownload(_ sender: AnyObject) {
    }
    
    @IBAction func updateAlpha(_ sender: UISlider) {
        
        // Doesn't work, float != CGFloat
        //imageView.alpha = sender.value
        
        let value = CGFloat(sender.value)
        
        imageView.alpha = value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    typealias completionClosure = (UIImage) -> ()

    func withURL(_ url: URL, completion : completionClosure) {
    
        DispatchQueue.global(qos: .userInitiated).async {
            do{
                let data = try Data(contentsOf: url)
                let img = UIImage(data: data)!
                
                // Finished. Execute completion function
                DispatchQueue.main.async {
                    completion(img)
                }
                
            } catch {
                print("Se fue a la puta")
            }
        }
    }

}
