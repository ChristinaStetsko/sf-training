import { LightningElement, wire, api, track } from "lwc";
import getAllCars from "@salesforce/apex/CarsLWCController.getAllCars";
import getShowroom from "@salesforce/apex/CarsLWCController.getShowroom";
import COLOR_FIELD from "@salesforce/schema/Car__c.Color__c";
import { getPicklistValues } from "lightning/uiObjectInfoApi";

const COLUMNS = [
	{ label: "Brand", fieldName: "carName" },
	{ label: "Model", fieldName: "carModel" },
	{ label: "Color", fieldName: "carColor" },
	{ label: "Price", fieldName: "carPrice", type: "currency" },
	{ label: "Showroom", fieldName: "showroomName" },
	{ label: "Car Owner", fieldName: "carOwnerName" },
	{ type: "button", label: "Detail", typeAttributes: { label: "Detail", name: "Detail" } },
	{
		type: "button",
		label: "Schedule Maintenance",
		typeAttributes: { label: "Schedule Maintenance", name: "Schedule Maintenance" }
	}
];

export default class CarListComponent extends LightningElement {
	carWrapperList;
	columns = COLUMNS;
	@wire(getAllCars)
	carsHandler({ data, error }) {
		if (data) {
			console.log(data);
			this.carWrapperList = data;
		}
		if (error) {
			console.log(error);
		}
	}

	//comboboxes start here:
	@wire(getPicklistValues, {
		recordTypeId: "012000000000000AAA",
		fieldApiName: COLOR_FIELD
	})
	colorPickLists({ error, data }) {
		if (data) {
			this.colorPickListValues = [...data.values];
		} else if (error) {
			console.error("error", error);
		}
	}
	handleChange(event) {
		this[event.target.name] = event.target.value;
		console.log("change", this[event.target.name]);
	}

	showroomPickListValues = [];
	@wire(getShowroom)
	getShowroom({ error, data }) {
		if (data) {
			for (var i = 0; i < data.length; i++) {
				this.showroomPickListValues = [...this.showroomPickListValues, { label: data[i].Name, value: data[i].Id }];
			}
		} else if (error) {
			console.error("error", error);
		}
	}

	@api showroom;
	handleShowroom(event) {
		this.showroom = event.target.value;
	}
	//comboboxes end here
}
