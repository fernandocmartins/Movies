//
//  TableViewController.swift
//  MoviesLib
//
//  Created by Fernando Cesar Martins on 02/09/22.
//

import UIKit
import CoreData

class MoviesTableViewController: UITableViewController {

    lazy var fetchedResutsController: NSFetchedResultsController<Movie> = {
        let fetchedRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchedRequest.sortDescriptors = [sortDescriptor]
        
        let fetchedResutsController = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResutsController.delegate = self
        
        return fetchedResutsController
    }()
    
    private let labelNoMovies: UILabel = {
       let label = UILabel()
        label.font = .italicSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.text = "Sem filmes cadastrados!"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let movieViewController = segue.destination as? MovieViewController,
              let indexPath = tableView.indexPathForSelectedRow else {return}
                
        movieViewController.movie = fetchedResutsController.object(at: indexPath)
    }
    
    //faz a leurura dos filmes
    private func loadMovies() {
        do {
            try fetchedResutsController.performFetch()
        }catch {
            print(error)
        }
    }

// quando tiver somente 1 secao... pode comentar
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    
    //retorna o numero de linhas
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let count = fetchedResutsController.fetchedObjects?.count ?? 0
        tableView.backgroundView = count == 0 ? labelNoMovies : nil
        return count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MovieTableViewCell else{
            return UITableViewCell()
        }

        let movie = fetchedResutsController.object(at: indexPath)
        cell.configure(with: movie)
        


        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

  
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movie = fetchedResutsController.object(at: indexPath)
            context.delete(movie)
            try? context.save()
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MoviesTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
