public without sharing class ResetPasswordController {
	private ApexPages.StandardController stdCtrl { get; set; }
	public String email { get; set; }
	public Boolean contactFound { get; set; }
	public Contact cont { get; set; }
	//public String subject { get;set; }
	//public List<String> hardcodeEmail = new List<String>{ 'stetsko.christina@gmail.com' };

	public ResetPasswordController(ApexPages.StandardController std) {
		stdCtrl = std;
		contactFound = false;
	}

	public PageReference sendPassword() {
		System.debug('>>>>>>>>>>>>>>> Get email from form: ' + email);

		cont = [SELECT FirstName, LastName, Email, Password__c FROM Contact WHERE Email = :email LIMIT 1];

		String password = (String) cont.get('Password__c');
		String[] replyTo = new List<String>{ email };

		System.debug('>>>>>>>>>>>>>>> ' + cont.Email + cont.Password__c);

		if (cont != null) {
			String emailBody = password;
			System.debug('>>>>>>>>>>>>>>>>>>>>>>>>> ' + email + ' password: ' + password);

			contactFound = true;
			Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();

			//mail.setSubject(subject);
			message.setPlainTextBody(emailBody);
			// message.setToAddresses(hardcodeEmail);
			// System.debug('>>>>>>>>>>>>>>>>>>>>>>>>> hardcode Email: ' + hardcodeEmail);
			
			message.setToAddresses(replyTo);
			System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>  Reply To: ' + replyTo);

			Messaging.SendEmailResult[] result = Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ message });

			System.debug('>>>>>>>>>>>>>>>>>>>>>>>>> ' + result);

			return new PageReference('/LoginPage');
		} else {
			contactFound = false; //add error message
		}
		return null;
	}
}
