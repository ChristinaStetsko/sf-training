import { LightningElement, track, wire} from 'lwc';
import getObjects from '@salesforce/apex/FieldExplorerController.getObjects';
import getFields from '@salesforce/apex/FieldExplorerController.getFields';

export default class FieldAccessExplorer extends LightningElement {
    @track objects = [];
    @track fields = [];
    @wire(getObjects)
    wiredMethod({ error, data }) {
        if (data) {
            this.dataArray = data;
            let tempArray = [];
            this.dataArray.forEach(function (element) {
                var option=
                {
                    label:element,
                    value:element
                };
                tempArray.push(option);
            });
            this.objects=tempArray;
        } else if (error) {
            this.error = error;
        }
    } 
    
    handleObjectChange(event)
    {   
        const selectedOption = event.detail.value;  
        getFields({ objectName: selectedOption})
        .then(result => {
            this.dataArray = result;
            let tempArray = [];
            this.dataArray.forEach(function (element) {
                var option=
                {
                    label:element.Label,
                    value:element.Name
                };
                tempArray.push(option);
            });
            this.fields=tempArray;
        })
        .catch(error => {
            this.error = error;
        });

    }
    handleFieldChange(){

    }
}