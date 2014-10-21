//
//  ViewController.swift
//  Apple Pay Example
//
//  Created by Michael Quinlan on 10/7/14.
//  Copyright (c) 2014 Clover Network Inc. All rights reserved.
//

import UIKit
import PassKit

class ViewController: UIViewController, PKPaymentAuthorizationViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func payTapped(AnyObject) {
        // Valiate that this device can take payments
        if (PKPaymentAuthorizationViewController.canMakePayments()) {
            // Construct the basic payment request
            var paymentRequest = PKPaymentRequest()
            paymentRequest.merchantIdentifier = "merchant.com.example";
            paymentRequest.supportedNetworks = [PKPaymentNetworkVisa, PKPaymentNetworkMasterCard, PKPaymentNetworkAmex]
            paymentRequest.merchantCapabilities = PKMerchantCapability.Capability3DS | PKMerchantCapability.CapabilityEMV
            paymentRequest.countryCode = "US"
            paymentRequest.currencyCode = "USD"
            paymentRequest.requiredShippingAddressFields = PKAddressField.All;
            
            // Add a line item
            var totalItem = PKPaymentSummaryItem(label:"Foo", amount:NSDecimalNumber(string:"0.05"))
            paymentRequest.paymentSummaryItems = [totalItem];
            
            // Show the Apple Pay controller
            var payAuth = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
            payAuth.delegate = self
            self.presentViewController(payAuth, animated:true, completion: nil)
        }
    }

    // Handle the callback with the payment information
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController!, didAuthorizePayment payment: PKPayment!, completion:((PKPaymentAuthorizationStatus) -> Void)!) {
        
        NSLog("%@", NSString(data:payment.token.paymentData, encoding:NSUTF8StringEncoding)!)
        
        completion(PKPaymentAuthorizationStatus.Success)
    }
    
    // The Apple Pay overlay has finished
    func paymentAuthorizationViewControllerDidFinish(controller: PKPaymentAuthorizationViewController!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}

