trigger CreateMaintenanceTrigger on Maintenance__c(before insert) {
    Set <Date> maintSet = new Set <Date>();
    Set <Date> existingMaint = new Set <Date>();

    for (Maintenance__c maintenance : Trigger.new) {
        maintSet.add(maintenance.Scheduled_date__c);
    }

    for (Maintenance__c maintenance : [SELECT Scheduled_date__c FROM Maintenance__c WHERE Scheduled_date__c in : maintSet]) {
        existingMaint.add(maintenance.Scheduled_date__c);
    }

    for (Maintenance__c maint : trigger.new) {
        if (existingMaint.contains(maint.Scheduled_date__c)) {
            maint.Scheduled_date__c.addError('This date is already scheduled. Choose another date.');
        }
    }
}