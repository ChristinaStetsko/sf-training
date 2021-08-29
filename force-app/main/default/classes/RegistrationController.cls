public with sharing class RegistrationController{

    private ApexPages.StandardController stdCtrl {get; set;}
    public Boolean error {get; set;}
    public String errorMessage {get; set;}
    
    // contstructor
    public RegistrationController(ApexPages.StandardController std){
        stdCtrl=std;
        error=false;
    }
    
    // action method to validate the input and save the Contact
    public PageReference save()
    { 
        PageReference pageReference = null;
        
        errorMessage='';
        error=false;
        Contact ld = (Contact) stdCtrl.getRecord();
        if ( (String.isEmpty(ld.Email)) || (String.isEmpty(ld.Password__c)) ){
            errorMessage='Please enter all required fields';
            error=true;
        } else {
            try {
                insert ld;
                pageReference = Page.HomePage;
                pageReference.getParameters().put('id', ld.id);
                pageReference.setRedirect(true);
            } catch (Exception e) {
                errorMessage='An error has occurred: ' + e.getMessage();
                error=true;
            }
        }
        return pageReference;
    }
}