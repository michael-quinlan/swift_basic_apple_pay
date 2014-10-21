This code contains a basic view controller that interacts with PassKit to take an Apple Pay payment. It does not link up any payment processor, and therefore stops after receiving the encrypted 3DS data from Apple. It servers as a Swift example of doing a raw Apple Pay payment.

One important step is that you must register a Merchant ID in the certificate section of your iOS developer portal. This exact Merchant ID string must be used in both the ViewController and the Entitlements file.
