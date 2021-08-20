public with sharing class LoginController {
    // The user input email
    public String email {get; set;}
    public String password {get; set;}
    public Boolean isAdmin {get; set;}
    
    // Indicator that a search has been run and a contact found
    public Boolean contactFound {get; set;}
    
    // The matching contact
    public Contact cont {get; set;}
    
    // Constructor
    public LoginController(){
        contactFound=false;
    }
    
    public PageReference forwardToHome() {
        List<Contact> conts=[SELECT FirstName, LastName, Email, Password__c  
                             FROM Contact 
                             WHERE Email=:email];
        if (conts.size()>0){
            cont=conts[0];
            if(cont.Password__c == password){
                contactFound=true;
                return new PageReference('/apex/HomePage');
            }
        } else {
            contactFound=false; //add error message
        }
        return null;
    } 
    
    public PageReference forwardToRegisterPage() {
        return new PageReference('/apex/RegistrationPage');
    }
    
    public PageReference forwardToResetPassword() {
        return new PageReference('/apex/ResetPassword');
    }
}