public without sharing class LoginController {
	public String email { get; set; }
	public String password { get; set; }
	public Boolean isAdmin { get; set; }
	public Boolean error { get; set; }
	public String errorMessage { get; set; }
	public Boolean contactFound { get; set; }
	public Contact cont { get; set; }

	// Constructor
	public LoginController() {
		contactFound = false;
		error = false;
	}

	public PageReference forwardToHome() {
		errorMessage = '';
		error = false;
		System.debug('>>>>>>>>>>>>>>> ' + email);

		Integer numbOfC = [SELECT COUNT() FROM Contact];
		System.debug('>>>>>>>>>>>>>>' + numbOfC);
		List<Contact> conts = [
			SELECT FirstName, LastName, Email, Password__c
			FROM Contact
			WHERE Email = :email AND Password__c = :password
			LIMIT 1
		];
		
		System.debug('>>>>>>>>>>>>>>> ' + conts);
		if (conts.size() > 0) {
			cont = conts[0];
			if (cont.Password__c == password) {
				contactFound = true;
				return new PageReference('/HomePage');
			}
		} else {
			errorMessage = 'Check email and password ';
			error = true;
			contactFound = false; //add error message
		}
		return null;
	}

	public PageReference forwardToRegisterPage() {
		return new PageReference('/RegistrationPage');
	}

	public PageReference forwardToResetPassword() {
		return new PageReference('/ResetPassword');
	}
}
