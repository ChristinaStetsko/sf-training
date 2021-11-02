public with sharing class CarsLWCController {
	@AuraEnabled(cacheable=true)
	public static List<CarWrapper> getAllCars() {
		List<CarWrapper> carWrapperList = new List<CarWrapper>();
		List<Car__c> carList = [
			SELECT Id, Name, Model__c, Color__c, Price__c, Showroom__r.Name, Car_Owner__r.Name
			FROM Car__c
			LIMIT 50
		];
		if (!carList.isEmpty()) {
			for (Car__c car : carList) {
				CarWrapper carsWrapper = new CarWrapper();
				carsWrapper.carId = car.Id;
				carsWrapper.carName = car.Name;
				carsWrapper.carModel = car.Model__c;
				carsWrapper.carColor = car.Color__c;
				carsWrapper.carPrice = car.Price__c;
				carsWrapper.showroomName = car.Showroom__r.Name;
				carsWrapper.carOwnerName = car.Car_Owner__r.Name;

				carWrapperList.add(carsWrapper);
			}
		}
		return carWrapperList;
	}

	@AuraEnabled(cacheable=true)
	public static List<Showroom__c> getShowroom() {
		List<Showroom__c> showroom = [SELECT Id, Name FROM Showroom__c];
		return showroom;
	}

	@AuraEnabled(Cacheable=true)
	public static List<Car__c> getBoats(String carColor, String ShowroomId) {
		// Without an explicit carColor, the full list is desired
		String query =
			'SELECT ' +
			'Id, Name, Model__c, Color__c, Price__c, Showroom__r.Name, Car_Owner__r.Name' +
			'FROM Car__c';
		if (String.isNotBlank(carColor)) {
			query += ' WHERE Color__c = :carColor';
		} if (String.isNotBlank(carColor)) {
			query += ' AND Showroom__r.Name = :ShowroomId';
		}
		query += ' WITH SECURITY_ENFORCED ';
		return Database.query(query);
	}

	public class CarWrapper {
		@AuraEnabled
		public String carId;
		@AuraEnabled
		public String carName;
		@AuraEnabled
		public String carModel;
		@AuraEnabled
		public String carColor;
		@AuraEnabled
		public Decimal carPrice;
		@AuraEnabled
		public String showroomName;
		@AuraEnabled
		public String carOwnerName;
	}
}
