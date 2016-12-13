//
//  ViewController.swift
//  gauge-lab
//
//  Created by vincent on 12/12/2016.
//  Copyright © 2016 kodappy. All rights reserved.
//

import UIKit
import GaugeKit

class ViewController: UIViewController {
    @IBOutlet weak var gauge: Gauge!
    @IBOutlet weak var slider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        gauge.rate = 50
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sliderValueChanged(sender: AnyObject) {
        if let slider = sender as? UISlider {
            gauge.rate = CGFloat(slider.value)
        }
    }

}

