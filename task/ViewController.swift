//
//  ViewController.swift
//  task
//
//  Created by monish-pt4670 on 23/10/1943 Saka.
//

import UIKit

class ViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var data : [Locations]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
        previousDots()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(Tapped))
        view.addGestureRecognizer(gesture)
       }
    func previousDots(){
        var i:Int=1
        print("\(self.data?[10].xposition ?? 1)")
        while(i<self.data!.count)
        {
            guard let locationx = self.data?[i].xposition else{
                return
            }
            guard let locationy = self.data?[i].yposition else{
                return
            }
            let label : UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            view.addSubview(label)
            view.addSubview(label)
            topAnchor = label.topAnchor.constraint(equalTo: view.topAnchor,constant: CGFloat(locationy) - 20)
            leadingAnchor = label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(locationx))
            trailingAnchor = label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20)
            heightAnchor = label.heightAnchor.constraint(equalToConstant: 20)
            widthAnchor = label.widthAnchor.constraint(equalToConstant: 10)
            topAnchor.isActive = true
            leadingAnchor.isActive = true
            trailingAnchor.isActive = true
            heightAnchor.isActive = true
            widthAnchor.isActive = true
            label.font = .boldSystemFont(ofSize: 20)
            label.text = "."
            i=i+1
        }
    }
    func fetchData()
    {
        do{
            try self.data = context.fetch(Locations.fetchRequest())
        }
        catch{
            fatalError()
        }
    }
    var topAnchor : NSLayoutConstraint!
    var trailingAnchor : NSLayoutConstraint!
    var heightAnchor : NSLayoutConstraint!
    var leadingAnchor : NSLayoutConstraint!
    var widthAnchor : NSLayoutConstraint!
    @objc func Tapped(_ sender:UITapGestureRecognizer)
    {
        let location = sender.location(in: view)
        let newLocation = Locations(context: self.context)
        newLocation.xposition = Float(location.x)
        newLocation.yposition = Float(location.y)
        do{
            try self.context.save()
        }
        catch{
            fatalError()
        }
        let label : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        label.isUserInteractionEnabled = true
        view.addSubview(label)
        topAnchor = label.topAnchor.constraint(equalTo: view.topAnchor,constant: location.y - 20)
        leadingAnchor = label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: location.x)
        trailingAnchor = label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20)
        heightAnchor = label.heightAnchor.constraint(equalToConstant: 20)
        widthAnchor = label.widthAnchor.constraint(equalToConstant: 10)
        topAnchor.isActive = true
        leadingAnchor.isActive = true
        trailingAnchor.isActive = true
        heightAnchor.isActive = true
        widthAnchor.isActive = true
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "."
}
}



