public without sharing class FilteredTableController {
	@AuraEnabled(cacheable=true)
	public static List<Car__c> getCars(String color) {
		String query;
		String condition = (String.isNotBlank(color) ? 'Color__c LIKE \'' + '%' + color + '%\'' : '');




		System.debug('condition ' + condition);

		if (String.isNotBlank(condition)) {
			query =
				'SELECT Id, Name, Model__c, Color__c, Price__c, Showroom__r.Name, Car_Owner__r.Name FROM Car__c WHERE ' +
				condition;
		} else {
			query = 'SELECT Id, Name, Model__c, Color__c, Price__c, Showroom__r.Name, Car_Owner__r.Name FROM Car__c LIMIT 200';
		}

		List<Car__c> records = Database.query(query);
		return records;
	}
}
