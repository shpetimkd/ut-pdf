//
//  ViewController.swift
//  UT-PDF
//
//  Created by Shpetim Kadrija on 24.5.23.
//
import PDFKit
import UIKit

class ViewController: UIViewController, PDFViewDelegate {
    
    // Views
    let pdfView = PDFView()
    private var currentPageIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pdfView)
        // Do any additional setup after loading the view.
        
        guard let url = Bundle.main.url(forResource: "swftui", withExtension: "pdf") else {
            return
        }
        guard let document = PDFDocument(url: url) else {
            return
        }
        pdfView.document = document
        pdfView.delegate = self
        pdfView.autoScales = true
        pdfView.displayMode = .singlePage
        pdfView.displayDirection = .horizontal
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandler(_:)))
        leftSwipeGesture.direction = .left
        view.addGestureRecognizer(leftSwipeGesture)
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandler(_:)))
        rightSwipeGesture.direction = .right
        view.addGestureRecognizer(rightSwipeGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        pdfView.frame = view.bounds
    }
    
    @objc private func swipeGestureHandler(_ gesture: UISwipeGestureRecognizer) {
        guard let document = pdfView.document else { return }
        
        //        let delayInSeconds: TimeInterval = 0.3
        
        if gesture.direction == .left {
            // Go to the next page with animation
            if currentPageIndex < document.pageCount - 1 {
                let nextPageIndex = currentPageIndex + 1
                animatePageTransition(to: nextPageIndex, direction: .forward)
            }
        } else if gesture.direction == .right {
            // Go to the previous page with animation
            if currentPageIndex > 0 {
                let previousPageIndex = currentPageIndex - 1
                animatePageTransition(to: previousPageIndex, direction: .reverse)
            }
        }
    }
    
    private func animatePageTransition(to pageIndex: Int, direction: UIPageViewController.NavigationDirection) {
        guard let document = pdfView.document else { return }
        
        let currentPage = document.page(at: currentPageIndex)
        let nextPage = document.page(at: pageIndex)
        
        let transition = CATransition()
        transition.type = .push
        transition.subtype = direction == .forward ? .fromRight : .fromLeft
        transition.duration = 0.3
        
        pdfView.layer.add(transition, forKey: nil)
        pdfView.go(to: nextPage!)
        
        currentPageIndex = pageIndex
    }
    
}

