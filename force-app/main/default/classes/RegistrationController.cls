public with sharing class RegistrationController{
    
    // the Contact standard controller being extended 
    private ApexPages.StandardController stdCtrl {get; set;}
    
    // indicator that an error occurred
    public Boolean error {get; set;}
    
    // the error message
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


/*
public with sharing class RegistrationController {

public RegistrationController(){
}

public String firstName {get;set;}
public String lastName{get;set;}
public String email {get;set;}
public String password {get;set;}


//create method createContact

public PageReference registerUser(){ 
System.debug('registerUser button =====>');
Contact cont = new Contact(); 
cont.FirstName = firstName;
cont.LastName = lastName;
cont.Email = email;
cont.Password__c = password; 

String contId;
contId = Site.createPortalUser(cont, contId, password); //insert contact
if(contId != null && password != null){
return Site.login(email, password, null);
} else{
PageReference page = System.Page.HomePage;
page.setRedirect(true);
return page;
}
}

public PageReference cancelRegistration(){
System.debug('cancelRegistration button =====>');
return null; //return to home
}
}
*/