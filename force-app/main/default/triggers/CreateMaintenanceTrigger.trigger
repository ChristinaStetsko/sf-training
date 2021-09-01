trigger CreateMaintenanceTrigger on Maintenance__c(before insert) {
    Maintenance__c maint = new Maintenance__c();
    maint.Car__c = Trigger.new[0].Car__c;
    maint.Showroom__c = Trigger.new[0].Showroom__c;
    maint.Scheduled_date__c = Trigger.new[0].Scheduled_date__c;
    insert maint;
}