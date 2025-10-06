trigger AccountAddressTrigger on Account (before insert, before update) {
    for (Account accountRecord : Trigger.new) {
        if (accountRecord.Match_Billing_Address__c == true) {
            accountRecord.ShippingPostalCode = accountRecord.BillingPostalCode;
        }
    }
}
