//
//  ViewController.swift
//  callenderApp
//
//  Created by Hamdy Youssef on 05/02/2024.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    var selectedDate = Date()
    var totlaSquares = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCellsView()
        setMonthView()
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totlaSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCell", for: indexPath) as! CallenderCell
        cell.dayOfMonth.text = totlaSquares[indexPath.item]
        
        return cell
    }
    
    func setMonthView() {
        totlaSquares.removeAll()
        let daysInMonth = CallenderHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CallenderHelper().FirstOfMonth(date: selectedDate)
        let startingSpaces = CallenderHelper().weekDay(date: firstDayOfMonth)
        
        var count: Int  = 1
        
        while (count <= 42) {
            if ( count <= startingSpaces || count - startingSpaces > daysInMonth ) {
                totlaSquares.append("")
            } else {
                totlaSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        monthLabel.text = CallenderHelper().monthString(date: selectedDate ) + " " + CallenderHelper().yearString(date: selectedDate)
        collectionView.reloadData()
        
        
    }
    
    func setCellsView() {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    @IBAction func previousMonth(_ sender: Any) {
        selectedDate = CallenderHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func nextMonth(_ sender: Any) {
        selectedDate = CallenderHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
}

