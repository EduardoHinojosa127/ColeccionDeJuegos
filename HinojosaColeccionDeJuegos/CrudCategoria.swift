//
//  CrudCategoria.swift
//  HinojosaColeccionDeJuegos
//
//  Created by Mac 04 on 17/05/23.
//

import UIKit

class CrudCategoria: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var txtCategoria: UITextField!
    
    
    
    @IBOutlet weak var eliminarCat: UIButton!
    @IBOutlet weak var agregarActualizarCategoria: UIButton!
    
    @IBAction func agregarCategoria(_ sender: Any) {
        if categoria != nil {
            categoria!.nombre! = txtCategoria.text!
 
        }else{
           let context = (UIApplication.shared.delegate as!
               AppDelegate).persistentContainer.viewContext
           let categoriaa = Categoria(context:context)
           categoriaa.nombre = txtCategoria.text
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    @IBAction func eliminarCategoria(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(categoria!)
        navigationController?.popViewController(animated: true)
    }
    
    var categoria:Categoria? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if categoria != nil {
            txtCategoria.text = categoria!.nombre
            agregarActualizarCategoria.setTitle("Actualizar", for: .normal)
        }else{
            eliminarCat.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
