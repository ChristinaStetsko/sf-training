public without sharing class LoginController {
	public String email { get; set; }
	public String password { get; set; }
	public Boolean isAdmin { get; set; }
	public Boolean contactFound { get; set; }
	public Contact cont { get; set; }

	public LoginController() {
		contactFound = false;
	}

	public PageReference forwardToHome() {
		List<Contact> conts = [
			SELECT FirstName, LastName, Email, Password__c
			FROM Contact
			WHERE Email = :email AND Password__c = :password
		];
		if (conts.size() > 0) {
			cont = conts[0];
			contactFound = true;
			return new PageReference('/HomePage');
		} else {
			contactFound = false;
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL, 'Please check Email & Password'));
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
