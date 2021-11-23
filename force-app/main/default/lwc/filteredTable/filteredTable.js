import { LightningElement, wire, api, track } from "lwc";
import getCars from "@salesforce/apex/FilteredTableController.getCars";
import { refreshApex } from "@salesforce/apex";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

import { getPicklistValues } from "lightning/uiObjectInfoApi";
import COLOR_FIELD from "@salesforce/schema/Car__c.Color__c";

export default class FilteredTable extends LightningElement {
	@track data;
	searchable = [];
	wiredCarCount;
	wiredCars;

	doneTypingInterval = 0;
	colorPickListValues;
	showroomPickListValues; //<<<<<<<<<------------------------

	searchAllValue;

	carNumber = "";
	carName = "";
	model = "";
	color = null;
	price = "";
	showroom = null;
	ownerName = "";

	@wire(getCars, {
		carNumber: "$carNumber",
		carName: "$carName",
		model: "$model",
		color: "$color",
		price: "$price",
		showroom: "$showroom",
		ownerName: "$ownerName"
	})
	wiredSObjects(result) {
		console.log("wire getting called");
		this.wiredCars = result;
		if (result.data) {
			this.searchable = this.data = result.data.map((carObj, index) => ({
				carData: { ...carObj },
				index: index + 1,
				rowIndex: index
			}));
		} else if (result.error) {
			console.error("Error", error);
		}
	}

	@wire(getPicklistValues, {
		recordTypeId: "012000000000000AAA",
		fieldApiName: COLOR_FIELD
	})
	colorPickLists({ error, data }) {
		if (error) {
			console.error("error", error);
		} else if (data) {
			this.colorPickListValues = [{ label: "All", value: null }, ...data.values];
		}
	}

	handleChange(event) {
		this[event.target.name] = event.target.value;
		console.log("change", this[event.target.name]);
	}

	handleKeyUp(event) {
		clearTimeout(this.typingTimer);
		let value = event.target.value;
		let name = event.target.name;

		this.typingTimer = setTimeout(() => {
			this[name] = value;
		}, this.doneTypingInterval);
	}

	clearSearch() {
		this.color = null;
		this.searchAll();
	}

	handleSearchAll(event) {
		this.searchAllValue = event.target.value;
		this.searchAll();
	}

	searchAll() {
		let searchStr = this.searchAllValue.toLowerCase();
		const regex = new RegExp("(^" + searchStr + ")|(." + searchStr + ")|(" + searchStr + "$)");
		if (searchStr.length > 2) {
			this.searchable = this.data.filter((item) => {
				if (regex.test(item.carData.Color__c?.toLowerCase() + " " + item.carData.Color__c?.toLowerCase())) {
					return item;
				}
			});
		} else if (this.carNumber.length <= 2) {
			this.searchable = this.data;
		}
		console.log(this.searchable);
	}
}
