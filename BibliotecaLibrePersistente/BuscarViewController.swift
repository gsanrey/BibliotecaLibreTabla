//
//  BuscarViewController.swift
//  BibliotecaLibrePersistente
//
//  Created by Gabriel Urso Santana Reyes on 23/12/15.
//  Copyright © 2015 Gabriel Urso Santana Reyes. All rights reserved.
//

import UIKit

class BuscarViewController: UIViewController {

    @IBOutlet weak var isbn: UITextField!

    @IBOutlet weak var lTitulo: UILabel!
    @IBOutlet weak var lAutores: UILabel!
    @IBOutlet weak var lTituloL: UILabel!
    @IBOutlet weak var lAutoresL: UILabel!
    
    var newLibro:Libro?
    var tablaBuscados : LibrosTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lTitulo.text = ""
        lAutores.text = ""

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
    
    @IBAction func buscar(sender: AnyObject) {
        let libro = obtenerLibro(isbn.text!)
        
        // añadir libro a Buscados e Ir al detalle del libro
        if libro != nil{
            tablaBuscados!.libros.append(libro!)
            tablaBuscados!.tableView.reloadData()
            self.newLibro = libro
            lTitulo.text = "Titulo"
            lAutores.text = "Autores"
            lTituloL.text = libro!.titulo
            var aut = ""
            for i in libro!.autores{
                aut = aut + i + " "
            }
            lAutoresL.text = aut
        }
    }

    
    func obtenerLibro(identificador : String) -> Libro?{
        var mensaje=""
        do{
            return try Libro(isbn: identificador)
        }catch (LibroError.ISBNNoEncontrado){
            mensaje = "ISBN no encontrado"
        }catch (LibroError.ErrorDeConexion){
            mensaje = "Error de Conexción"
        }catch _{
            mensaje = "ERROR"
        }
        
        // Muestra mensaje de error dependiendo de lo sucedido
        let alert = UIAlertController(title: "Error", message: mensaje, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                print("default")
            case .Cancel:
                print("cancel")
            case .Destructive:
                print("destructive")
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        return nil
    }

/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("estamos por quí")
        let destino = segue.destinationViewController
        
        if destino is InfoLibroViewController {
            let infoLibro = segue.destinationViewController as! InfoLibroViewController
            infoLibro.libro = self.newLibro
            print("SEGUE CON EL LIBRO")
            print(self.newLibro?.titulo)
        }

    }
*/

}
