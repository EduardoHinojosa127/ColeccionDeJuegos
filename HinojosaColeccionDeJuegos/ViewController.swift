//
//  ViewController.swift
//  HinojosaColeccionDeJuegos
//
//  Created by Mac 04 on 17/05/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let juego = juegos[indexPath.row]
        cell.textLabel?.text = juego.titulo
        cell.imageView?.image = UIImage(data: (juego.imagen!))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return juegos.count
    }
    

    @IBAction func editar(_ sender: Any) {
        tableView.isEditing = false
    }
    @IBOutlet weak var tableView: UITableView!
    var juegos:[Juego] = []
    var categorias:[Categoria] = []
    
    @IBAction func eliminar(_ sender: Any) {
        tableView.isEditing = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            try juegos = context.fetch(Juego.fetchRequest())
            tableView.reloadData()
        }catch{
            
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let juego = juegos[sourceIndexPath.row]
        juegos.remove(at: sourceIndexPath.row)
        juegos.insert(juego, at: destinationIndexPath.row)
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            try context.save()
        } catch {
            // Manejar el error en caso de fallo al guardar los cambios
        }
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let juego = juegos[indexPath.row]
        performSegue(withIdentifier: "juegoSegue", sender: juego)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "juegoSegue" {
            if let siguienteVC = segue.destination as? JuegosViewController {
                if let juego = sender as? Juego {
                    siguienteVC.juego = juego
                } else {
                    // Manejar el caso en el que el sender no sea del tipo esperado
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let juego = juegos[indexPath.row]
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(juego)
            
            do {
                try context.save()
                juegos.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                // Manejar el error en caso de fallo al guardar los cambios o eliminar el registro
            }
        }
    }

    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    
}

