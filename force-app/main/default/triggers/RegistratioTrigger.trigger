trigger RegistratioTrigger on Contact (before insert) {
    Set <String> emailSet = new Set <String>();
    Set <String> existingEmail = new Set <String>();

    for (Contact cont : Trigger.new) {
        emailSet.add(cont.Email);
    }

    for (Contact cont : [SELECT Email FROM Contact WHERE email in : emailSet]) {
        existingEmail.add(cont.Email);
        //if select.size > 0 >>>>>>> error
        //TriggerHelper
    }

    for (Contact con : trigger.new) {
        if (existingEmail.contains(con.Email)) {
            con.Email.addError('This email already exists');
        }
    }
}


/*
Trigger isAfter triggerisInsert
добавить trigger isBefore и trigger isAfter insert + TriggerHelper (TriggerHandler).
Call helper
*/