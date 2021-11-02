public class LoginLWCController {
	
	@AuraEnabled(cacheable=true)
	public static List<Contact> findContacts(String searchEmail, String searchPassword) {
        String email = searchEmail;
        String password = searchPassword;
        return [
            SELECT Id, Name, Email, Password__c
            FROM Contact
            WHERE Email =: email
			AND Password__c =: password
        ];
    }

}
