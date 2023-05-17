//
//  CategoriasController.swift
//  HinojosaColeccionDeJuegos
//
//  Created by Mac 04 on 17/05/23.
//

import UIKit

class CategoriasController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var categorias:[Categoria] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let categoria = categorias[indexPath.row]
        cell.textLabel?.text = categoria.nombre
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            try categorias = context.fetch(Categoria.fetchRequest())
            tableView.reloadData()
        }catch{
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoria = categorias[indexPath.row]
        performSegue(withIdentifier: "categoriaSegue", sender: categoria)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoriaSegue" {
            if let siguienteVC = segue.destination as? CrudCategoria {
                if let categoria = sender as? Categoria {
                    siguienteVC.categoria = categoria
                } else {
                    // Manejar el caso en el que el sender no sea del tipo esperado
                }
            }
        }
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
