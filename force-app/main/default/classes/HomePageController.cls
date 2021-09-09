public class HomePageController {
	public String colorPickValue { get; set; }
	public String showroomPickValue { get; set; }
	public Car__c currentRecord { get; set; }
	public String recordId { get; set; }
	public List<Car__c> carsList { get; set; }

	public void getCars() {
		carsList = new List<Car__c>(
			[
				SELECT Id, Name, Model__c, Color__c, Price__c, Showroom__r.Name, Car_Owner__r.Name
				FROM Car__c
				WHERE Color__c = :colorPickvalue
				AND Showroom__r.Name = :showroomPickValue
				LIMIT 50
			]
		);
		System.debug('1>>>>>>>>>>>>>>>>>>>>>>>>>>>' + carsList);
	}

	public List<SelectOption> getSelectColor() {
		List<SelectOption> optionsColor = new List<SelectOption>();
		Schema.DescribeFieldResult colorField = Car__c.Color__c.getDescribe();
		System.debug('2>>>>>>>>>>>>>>>>>>>>>>>>>>>' + colorField);
		optionsColor.add(new SelectOption('--Select color--', '--Select color--'));
		for (Schema.PicklistEntry picklistEntry : colorField.getPicklistValues()) {
			optionsColor.add(new SelectOption(picklistEntry.getValue(), picklistEntry.getLabel()));
		}
		System.debug('3>>>>>>>>>>>>>>>>>>>>>>>>>>>' + optionsColor);
		return optionsColor;
	}

	public List<SelectOption> getSelectShowroom() {
		List<SelectOption> optionsShowroom = new List<SelectOption>();
		List<Car__c> cList = new List<Car__c>();
		cList = [SELECT Id, Showroom__r.Name FROM Car__c];
		System.debug('55555>>>>>>>>>>>>>>>>>>>>>>>>>>>' + cList);
		optionsShowroom.add(new SelectOption('--Select showroom--', '--Select showroom--'));
		for (Car__c showroom : cList) {
				optionsShowroom.add(new SelectOption(showroom.Id, showroom.Showroom__r.Name));
		}
		System.debug('66666>>>>>>>>>>>>>>>>>>>>>>>>>>>' + optionsShowroom);
		return optionsShowroom;
	}

	public PageReference getId() {
		PageReference ref = new PageReference('HomePage');
		ref.getParameters().put('id', recordId);
		System.debug('66666>>>>>>>>>>>>>>>>>>>>>>>>>>>' + recordId);
		ref.setRedirect(true);
		return ref;
	}

	// public PageReference getRec() {
	// 	currentRecord = [SELECT Id, Name FROM Car__c WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
	// 	System.debug('9999999>>>>>>>>>>>>>>>>>>>>>>>>>>>' + currentRecord);
	// 	return null;
	// }

	//public PageReference getCarDetail() {
	//String myID = apexpages.currentPage().getParameters().get('id');
	// PageReference reference = new PageReference('/CarDetailPage');
	// reference.getParameters().put('id',recordId);
	// System.debug('66666>>>>>>>>>>>>>>>>>>>>>>>>>>>' + reference);
	// reference.setRedirect(true);
	// return reference;
	//}
}
