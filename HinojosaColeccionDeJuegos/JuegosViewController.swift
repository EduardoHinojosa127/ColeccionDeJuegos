//
//  JuegosViewController.swift
//  HinojosaColeccionDeJuegos
//
//  Created by Mac 04 on 17/05/23.
//

import UIKit

class JuegosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate,
                            UIPickerViewDataSource{
    
    var categorias:[Categoria] = []
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categorias.count
    }
    
    
    @IBOutlet weak var eliminarBoton: UIButton!
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    var imagePicker = UIImagePickerController()
    var juego:Juego? = nil
    var opcionSeleccionada:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        comboBox.dataSource = self
        comboBox.delegate = self
        imagePicker.delegate = self
        if juego != nil {
            imageView.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo
            txtCategoria.text = juego!.categoria
            let nombresCategorias = categorias.map { $0.nombre }
            let index:Int = nombresCategorias.firstIndex(where: { $0 == juego!.categoria }) ?? 0
            comboBox.selectRow(index, inComponent: 0, animated: false)
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
        }else{
            eliminarBoton.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var txtCategoria: UITextField!
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagenSeleccionada = info[.originalImage] as? UIImage
        imageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func camaraTapped(_ sender: Any) {
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var tituloTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            try categorias = context.fetch(Categoria.fetchRequest())
        }catch{
            
        }
    }
    
    @IBAction func agregarTapped(_ sender: Any) {
        if juego != nil {
           juego!.titulo! = tituloTextField.text!
           juego!.imagen = imageView.image?.jpegData(compressionQuality: 0.50)
            txtCategoria.text = opcionSeleccionada
            juego?.categoria = txtCategoria.text
        }else{
           let context = (UIApplication.shared.delegate as!
               AppDelegate).persistentContainer.viewContext
           let juego = Juego(context:context)
           juego.titulo = tituloTextField.text
           juego.imagen = imageView.image?.jpegData(compressionQuality: 0.50)
            juego.categoria = opcionSeleccionada
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var comboBox: UIPickerView!
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return categorias[row].nombre!
        }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        opcionSeleccionada = (comboBox.delegate?.pickerView?(comboBox, titleForRow: row, forComponent: component))!
    }

    
    
}
