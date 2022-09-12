//
//  ViewController.swift
//  CoreDaraSecondExample
//
//  Created by M1 on 12.09.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    private var datasourse: [Worker] = []
    private var viewContext: NSManagedObjectContext { return CoreDataManager.instance.persistentContainer.viewContext}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        fetchAllData()
    }
    
    func generateData() {
        CoreDataManager.instance.persistentContainer.performBackgroundTask { bgContext in
            let department = Departmen(context: bgContext)
            department.name = "Text Dep"
            let names = ["John", "Alex", "Bob", "Bill", "Ben"]
            for (index, name) in names.enumerated() {
            let worker = Worker(context: bgContext)
            worker.name = name
            worker.salary = Int64(20_000 * (index + 1))
            worker.department = department
            department.addToWorker(worker)
        }
            let worker = Worker(context: bgContext)
            worker.name = "Ben"
            worker.salary = 80_000
            worker.department = department
            department.addToWorker(worker)
            
            try? bgContext.save()
        }
    }
    func fetchHighSalaryData() {
        let fetch: NSFetchRequest<Worker> = Worker.fetchRequest()
        fetch.predicate = NSPredicate(format: "\(#keyPath(Worker.salary)) > 60000")
        let nameDescriptor = NSSortDescriptor(key: #keyPath(Worker.name),
                                              ascending: true,
                                              selector: #selector(NSString.localizedStandardCompare(_:)) )
        fetch.sortDescriptors = [nameDescriptor]
        datasourse = (try? viewContext.fetch(fetch)) ?? []
        tableView.reloadSections(IndexSet(integer: 0), with: .none)
    }
    
    func fetchAllData() {
        let fetch: NSFetchRequest<Worker> = Worker.fetchRequest()
        datasourse = (try? viewContext.fetch(fetch)) ?? []
        tableView.reloadSections(IndexSet(integer: 0), with: .none)
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            fetchAllData()
        case 1:
            fetchHighSalaryData()
        default:
            break
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        datasourse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseID", for: indexPath)
        let item = datasourse[indexPath.row]
        cell.textLabel?.text = item.name ?? ""
        cell.detailTextLabel?.text = "Salary = \(item.salary)"
        return cell
    }
}
