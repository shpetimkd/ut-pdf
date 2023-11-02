//
//  ViewController.swift
//  UT-PDF
//
//  Created by Shpetim Kadrija on 24.5.23.
//
import PDFKit
import UIKit

class PDFViewController: UIViewController, PDFViewDelegate {

    // Views
    let pdfView = PDFView()
    
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
        pdfView.displayMode = .singlePageContinuous
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        pdfView.frame = view.bounds
    }


}

