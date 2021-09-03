public class ResetPasswordController {
	private ApexPages.StandardController stdCtrl { get; set; }
	public String email { get; set; }
	public Boolean contactFound { get; set; }
	public Contact cont = new Contact(); //Email = TestEmail
	//public String subject { get;set; }

	public ResetPasswordController(ApexPages.StandardController std) {
		stdCtrl = std;
		contactFound = false;
	}

	public PageReference sendPassword() {
		try {
			cont = [SELECT  Email, Password__c FROM Contact WHERE Email = :email LIMIT 1];
		} catch (Exception e) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Сheck your email'));
			return null;
		}

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
			message.setToAddresses(replyTo);
			System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>  Reply To: ' + replyTo);

			Messaging.SendEmailResult[] result = Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ message });

			System.debug('>>>>>>>>>>>>>>>>>>>>>>>>> ' + result);

			return new PageReference('/LoginPage');
		} else {
			contactFound = false;
			ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.FATAL, 'Please check Email'));
		}
		return null;
	}
}
